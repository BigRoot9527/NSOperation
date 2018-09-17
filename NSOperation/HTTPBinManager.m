//
//  HTTPBinManager.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "HTTPBinManager.h"
@interface HTTPBinManager()
@property (nonatomic, strong) NSOperationQueue* operationQueue;

@end


@implementation HTTPBinManager

+ (instancetype)sharedInstance
{
    static HTTPBinManager *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[HTTPBinManager alloc] init];
    });
    return instace;
}

@end
