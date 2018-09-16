//
//  HTTPRequestProvider.h
//  NSOperation
//
//  Created by 許庭瑋 on 2018/9/16.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KKRequestType) {
    KKRequestTypeGet = 0,
    KKRequestTypePost = 1,
    KKRequestTypeImage = 2,
};

@interface HTTPRequestProvider : NSObject

- (NSMutableURLRequest*)requestOfKKReqiestType:(KKRequestType)type urlenStringForPost:(NSString *)postString;


@end
