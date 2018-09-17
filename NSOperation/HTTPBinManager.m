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
    HTTPBinManagerOperation *operation = [[HTTPBinManagerOperation alloc] initWithDelegate:self];
    [self.operationQueue addOperation:operation];
    [self.delegate managerDidStartOperation:self];
}

- (void)cancelOperation
{
    [self.operationQueue cancelAllOperations];
}

@end

@implementation HTTPBinManager(HTTPBinManagerOperationDelegate)
- (void)operation:(HTTPBinManagerOperation *)op didFailLoadingWithError:(NSError *)error
{
    [self.delegate manager:self didEndCurrentOperationWithError:error];
}

- (void)operation:(HTTPBinManagerOperation *)op didFinishAllRequestWithGETResponseDict:(NSDictionary *)getDict AndPostResponseDict:(NSDictionary *)postDict AndResponseImage:(UIImage *)image
{
    [self.delegate manager:self didFinishCurrentOperationWithGetDict:getDict andPostDict:postDict andImage:image];
}

- (void)operation:(HTTPBinManagerOperation *)op didUpdateLoadingProcessPercentageTo:(NSInteger)percentage
{
    [self.delegate manager:self didUpdateCurrentLoadingProgressPercentage:percentage];
}

@end
