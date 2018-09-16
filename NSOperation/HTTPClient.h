//
//  APIClient.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface HTTPClient : NSObject
+ (instancetype)sharedInstance;
- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback;
- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback;
- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback;
@end
