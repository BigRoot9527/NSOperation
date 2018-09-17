//
//  HTTPBinManagerOperation.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "HTTPBinManagerOperation.h"
#import "HTTPClient.h"
@interface HTTPBinManagerOperation()
@property (nonatomic, strong) HTTPClient *client;
@property (nonatomic) dispatch_semaphore_t sem;
@property (nonatomic, strong) NSDictionary* postDict;
@property (nonatomic, strong) NSDictionary* getDict;
@property (nonatomic, strong) UIImage* image;
@property(nonatomic, weak) id<HTTPBinManagerOperationDelegate> delegate;
@end

@implementation HTTPBinManagerOperation

- (instancetype)initWithDelegate:(id <HTTPBinManagerOperationDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.client = [HTTPClient sharedInstance];
        self.sem = dispatch_semaphore_create(0);
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    self.client = nil;
    self.sem = nil;
    self.getDict = nil;
    self.postDict = nil;
    self.image = nil;
}

- (void)main
{
    [self _loadGetRequestFromClient];
}

- (void)cancel
{
    [super cancel];
    [self.client cancelRequest];
    dispatch_semaphore_signal(self.sem);
}

- (void)_loadGetRequestFromClient
{
    if (self.isCancelled) {
        return;
    }
    [self.client fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didUpdateLoadingProcessPrecentageTo:33];
                self.getDict = dict;
            });
            dispatch_semaphore_signal(self.sem);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didFailLoadingWithError:error];
            });
            [self cancel];
        }
    }];
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
    [self _loadPostRequestFromClient];
}

- (void)_loadPostRequestFromClient
{
    if (self.isCancelled) {
        return;
    }
    [self.client postCustomerName:@"BigRoot" callback:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didUpdateLoadingProcessPrecentageTo:66];
                self.postDict = dict;
            });
            dispatch_semaphore_signal(self.sem);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didFailLoadingWithError:error];
            });
            [self cancel];
        }
    }];
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
    [self _loadPostRequestFromClient];
}

- (void)_loadImageRequestFromClient
{
    if (self.isCancelled) {
        return;
    }
    [self.client fetchImageWithCallback:^(UIImage *image, NSError *error) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didUpdateLoadingProcessPrecentageTo:100];
            });
            dispatch_semaphore_signal(self.sem);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didFailLoadingWithError:error];
            });
            [self cancel];
        }
    }];
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
    [self _finishAndPassAllResponse];
}

- (void)_finishAndPassAllResponse
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate operation:self didFinishAllRequestWithGETResponseDict:self.getDict AndPostResponseDict:self.postDict AndResponseImage:self.image];
    });
}

@end
