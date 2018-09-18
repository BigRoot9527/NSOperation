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


@implementation HTTPBinManagerOperationResponse
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
    [self _loadGetRequest];
    [self _loadPostRequest];
    [self _loadImageRequest];
    [self _passAllResponse];
}

- (void)cancel
{
    [super cancel];
    [self.client cancelRequest];
    dispatch_semaphore_signal(self.sem);
}

- (void)_loadGetRequest
{
    if (self.isCancelled) {
        return;
    }
    [self.client fetchGetResponseWithCallback:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didLoadToPercentage:33];
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
}

- (void)_loadPostRequest
{
    if (self.isCancelled) {
        return;
    }
    [self.client postCustomerName:@"BigRoot" callback:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didLoadToPercentage:66];
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
}

- (void)_loadImageRequest
{
    if (self.isCancelled) {
        return;
    }
    [self.client fetchImageWithCallback:^(UIImage *image, NSError *error) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate operation:self didLoadToPercentage:100];
                self.image = image;
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
}

- (void)_passAllResponse
{
    if(self.isCancelled) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        HTTPBinManagerOperationResponse *response = [[HTTPBinManagerOperationResponse alloc] init];
        response.getDictionary = self.getDict;
        response.postDictionary = self.postDict;
        response.image = self.image;
        [self.delegate operation:self didFinishWithResponse:response];
    });
}

@end
