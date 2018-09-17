//
//  NSData+DataConvert.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/14.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSData (DataConvert)

- (NSDictionary*)dictionaryFromDataWithErrorHandler:(NSError**)handler;
- (UIImage*)imageFromDataWithErrorHandler:(NSError**)handler;

@end
