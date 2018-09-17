//
//  NSData+DataConvert.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "NSData+DataConvert.h"

@implementation NSData (DataConvert)

- (NSDictionary*)dictionaryFromDataWithErrorHandler:(NSError**)handler;
{
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        *handler = err;
        return nil;
    }
    return dict;
}

- (UIImage*)imageFromDataWithErrorHandler:(NSError**)handler;
{
    UIImage *image = [UIImage imageWithData:self];
    if (!image) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"fail to transfer to UIImage" forKey:NSDebugDescriptionErrorKey];
        *handler = [[NSError alloc] initWithDomain:@"com.NSOperation.BigRoot" code:-1 userInfo:details];
        return nil;
    }
    return image;
}


@end
