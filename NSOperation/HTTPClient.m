//
//  APIClient.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//


#import "HTTPClient.h"
#import "NSData+DataConvert.h"


typedef NS_ENUM(NSInteger, KKRequestType) {
    KKRequestTypeGet = 0,
    KKRequestTypePost = 1,
    KKRequestTypeImage = 2,
};
@interface HTTPClient()
@property(nonatomic,strong) NSURLSession *session;
@end

@implementation HTTPClient

+ (instancetype)sharedInstance
{
    static HTTPClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPClient alloc] init];
        instance.session = [NSURLSession sharedSession];
    });
    return instance;
}

- (NSURL *)_urlForRequestType: (KKRequestType)type
{
    NSString *urlString;
    switch (type) {
        case KKRequestTypeGet:
            urlString = @"https://httpbin.org/get";
            break;
        case KKRequestTypePost:
            urlString = @"https://httpbin.org/post";
            break;
        case KKRequestTypeImage:
            urlString = @"https://httpbin.org/image/png";
    }
    return [[NSURL alloc] initWithString:urlString];
}

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self _urlForRequestType:KKRequestTypeGet]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callback([data dictionaryFromData], error);
    }];
    [dataTask resume];
}
- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback
{
    NSString *post = [NSString stringWithFormat:@"name=%@",name];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self _urlForRequestType:KKRequestTypePost]];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callback([data dictionaryFromData], error);
    }];
    [dataTask resume];
}

- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self _urlForRequestType:KKRequestTypeImage]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callback([data imageFromData], error);
    }];
    [dataTask resume];
}

@end
