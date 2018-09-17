//
//  HTTPBinManagerOperation.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTTPBinManagerOperation;
@protocol HTTPBinManagerOperationDelegate
- (void)operation:(HTTPBinManagerOperation *)op didFailLoadingWithError:(NSError*)error;
- (void)operation:(HTTPBinManagerOperation *)op didUpdateLoadingProcessPercentageTo:(NSInteger)percentage;
- (void)operation:(HTTPBinManagerOperation *)op didFinishAllRequestWithGETResponseDict:(NSDictionary*)getDict AndPostResponseDict:(NSDictionary*)postDict AndResponseImage:(UIImage*)image;
@end

@interface HTTPBinManagerOperation : NSOperation
- (instancetype)initWithDelegate:(id <HTTPBinManagerOperationDelegate>)delegate;
@end
