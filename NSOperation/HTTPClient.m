//
//  APIClient.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//


#import "HTTPClient.h"
#import "NSData+DataConvert.h"
#import "HTTPRequestProvider.h"

@interface HTTPClient()
@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) HTTPRequestProvider *requestProvider;
@property(nonatomic, strong) NSURLSessionDataTask *currentDataTask;
@end

@implementation HTTPClient

+ (instancetype)sharedInstance
{
    static HTTPClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPClient alloc] _init];
        
    });
    return instance;
}

- (instancetype)init
{
    return [[self class] sharedInstance];
}

- (instancetype)_init
{
    self = [super init];
    if (self) {
        self.session = [NSURLSession sharedSession];
        self.requestProvider = [[HTTPRequestProvider alloc] init];
    }
    return self;
}

- (void)cancelRequest
{
    [self.currentDataTask suspend];
    [self.currentDataTask cancel];
}

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback
{
    NSMutableURLRequest *request = [self.requestProvider requestWithType:KKRequestTypeGet postString:nil];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *err;
            NSDictionary *dict = [data dictionaryFromDataWithError:&err];
            callback(dict, error == nil ? err : error);
        });
    }];
    [dataTask resume];
    self.currentDataTask = dataTask;
}
- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback
{
    NSString *postString = [NSString stringWithFormat:@"custname=%@",name];
    NSMutableURLRequest *request = [self.requestProvider requestWithType:KKRequestTypePost postString:postString];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *err;
            NSDictionary *dict = [data dictionaryFromDataWithError:&err];
            callback(dict, error == nil ? err : error);
        });
    }];
    [dataTask resume];
    self.currentDataTask = dataTask;
}

- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback
{
    NSMutableURLRequest *request = [self.requestProvider requestWithType:KKRequestTypeImage postString:nil];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *err;
            UIImage *image = [data imageFromDataWithError:&err];
            callback(image, error == nil ? err : error);
        });
    }];
    [dataTask resume];
    self.currentDataTask = dataTask;
}

@end
