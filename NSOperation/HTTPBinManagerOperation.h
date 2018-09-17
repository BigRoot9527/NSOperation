//
//  HTTPBinManagerOperation.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KKRequestType.h"

@class HTTPBinManagerOperation;
@protocol HTTPBinManagerOperationDelegate
- (void)operation:(HTTPBinManagerOperation *)op didFailLoadingWithError:(NSError*)error FromRequestType:(KKRequestType)type;
- (void)operation:(HTTPBinManagerOperation *)op didUpdateLoadingProcessPrecentageTo:(NSInteger)percentage;
- (void)operation:(HTTPBinManagerOperation *)op didFinishAllRequestWithGETResponseDict:(NSDictionary*)dict AndPostResponseDict:(NSDictionary*)dict AndResponseImage:(UIImage*)image;
@end

@interface HTTPBinManagerOperation : NSOperation
@property(nonatomic, weak) id<HTTPBinManagerOperationDelegate> delegate;
@end
