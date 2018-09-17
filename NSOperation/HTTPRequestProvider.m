//
//  HTTPRequestProvider.m
//  NSOperation
//
//  Created by 許庭瑋 on 2018/9/16.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "HTTPRequestProvider.h"

@implementation HTTPRequestProvider

- (NSMutableURLRequest*)requestWithType:(KKRequestType)type urlenStringForPostRequest:(NSString *)postString
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self _urlForRequestType:type]];
    [request setHTTPMethod:[self _httpMethodStringForRequestType:type]];
    
    if (type == KKRequestTypePost) {
        NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
    }
    return request;
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

- (NSString *)_httpMethodStringForRequestType: (KKRequestType)type
{
    switch (type) {
        case KKRequestTypeGet:
            return @"GET";
            break;
        case KKRequestTypePost:
            return @"POST";
            break;
        case KKRequestTypeImage:
            return @"GET";
            break;
    }
}


@end
