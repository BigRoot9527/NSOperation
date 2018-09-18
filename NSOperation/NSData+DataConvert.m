//
//  NSData+DataConvert.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "NSData+DataConvert.h"

NSString * const BigRootErrorDomain = @"com.NSOperation.BigRoot";

@implementation NSData (DataConvert)

- (NSDictionary*)dictionaryFromDataWithError:(NSError**)error;
{
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        *error = err;
        return nil;
    }
    if (![dict isKindOfClass:[NSDictionary class]]) {
        err = [NSError errorWithDomain:BigRootErrorDomain code:-2 userInfo:@{NSLocalizedDescriptionKey: @"Not a dictionary"}];
        *error = err;
        return nil;
    }
    
    return dict;
}

- (UIImage*)imageFromDataWithError:(NSError**)error;
{
    UIImage *image = [UIImage imageWithData:self];
    if (!image) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"fail to transfer to UIImage" forKey:NSDebugDescriptionErrorKey];
        *error = [[NSError alloc] initWithDomain:BigRootErrorDomain code:-1 userInfo:details];
        return nil;
    }
    return image;
}


@end
