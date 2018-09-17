//
//  HTTPBinManager.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "HTTPBinManager.h"
#import "HTTPBinManagerOperation.h"

@interface HTTPBinManager()
@property (nonatomic, strong) NSOperationQueue* operationQueue;
@property(nonatomic,strong) NSDictionary *getDictionary;
@property(nonatomic,strong) NSDictionary *postDictionary;
@property(nonatomic,strong) UIImage *getImage;
@property(nonatomic,strong) NSString *errorMassage;
@end

@interface HTTPBinManager(HTTPBinManagerOperationDelegate)<HTTPBinManagerOperationDelegate>
@end

@implementation HTTPBinManager

+ (instancetype)sharedInstance
{
    static HTTPBinManager *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[HTTPBinManager alloc] _init];
        
    });
    return instace;
}

- (instancetype)init
{
    return [[self class] sharedInstance];
}

- (instancetype)_init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)executeOperation
{
    [self.operationQueue cancelAllOperations];
    [self _resetDataProperties];
    HTTPBinManagerOperation *operation = [[HTTPBinManagerOperation alloc] initWithDelegate:self];
    [self.operationQueue addOperation:operation];
}

- (void)cancelOperation
{
    [self.operationQueue cancelAllOperations];
    [self _resetDataProperties];
}

- (void)_resetDataProperties
{
    self.getDictionary = nil;
    self.postDictionary = nil;
    self.getImage = nil;
    self.errorMassage = nil;
}

@end

@implementation HTTPBinManager(HTTPBinManagerOperationDelegate)
- (void)operation:(HTTPBinManagerOperation *)op didFailLoadingWithError:(NSError *)error {
    self.errorMassage = [error description];
    [self.delegate managerDidFinishedCurrentOperation:self];
}

- (void)operation:(HTTPBinManagerOperation *)op didFinishAllRequestWithGETResponseDict:(NSDictionary *)getDict AndPostResponseDict:(NSDictionary *)postDict AndResponseImage:(UIImage *)image {
    if (getDict && postDict && image) {
        self.postDictionary = postDict;
        self.getDictionary = getDict;
        self.getImage = image;
        self.errorMassage = nil;
    } else {
        self.errorMassage = @"response data parsing error";
    }
    [self.delegate managerDidFinishedCurrentOperation:self];
}

- (void)operation:(HTTPBinManagerOperation *)op didUpdateLoadingProcessPrecentageTo:(NSInteger)percentage {
    [self.delegate manager:self DidUpdateCurrentLoadingProgressPercentage:percentage];
}

@end
