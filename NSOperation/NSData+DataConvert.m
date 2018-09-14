//
//  NSData+DataConvert.m
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "NSData+DataConvert.h"

@implementation NSData (DataConvert)

- (NSDictionary *)dictionaryFromData
{
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&err];
    
    if(err)
    {
        NSLog(@"json parse fail：%@",err);
        return nil;
    }
    return dict;
}

- (UIImage *)imageFromData
{
    UIImage *image = [UIImage imageWithData:self];
    if (!image) {
        NSLog(@"fail to transfer to UIImage");
    }
    return image;
}


@end
