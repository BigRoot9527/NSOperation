//
//  HTTPBinManagerOperation.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTTPBinManagerOperationResponse;

@class HTTPBinManagerOperation;
@protocol HTTPBinManagerOperationDelegate
- (void)operation:(HTTPBinManagerOperation *)op didFailLoadingWithError:(NSError*)error;
- (void)operation:(HTTPBinManagerOperation *)op didLoadToPercentage:(NSInteger)percentage;
- (void)operation:(HTTPBinManagerOperation *)op didFinishWithResponse:(HTTPBinManagerOperationResponse *)response;
@end

/** The response for HTTPBinManagerOperation. */
@interface HTTPBinManagerOperationResponse : NSObject
@property (strong, nonnull, nonatomic) NSDictionary *getDictionary;
@property (strong, nonnull, nonatomic) NSDictionary *postDictionary;
@property (strong, nonnull, nonatomic) UIImage *image;
@end

@interface HTTPBinManagerOperation : NSOperation
- (nonnull instancetype)initWithDelegate:(nonnull id <HTTPBinManagerOperationDelegate>)delegate;
@end
