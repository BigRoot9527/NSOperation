//
//  HTTPRequestProvider.h
//  NSOperation
//
//  Created by 許庭瑋 on 2018/9/16.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKRequestType.h"


@interface HTTPRequestProvider : NSObject
- (NSMutableURLRequest*)requestWithType:(KKRequestType)type urlenStringForPostRequest:(NSString *)postString;
@end
