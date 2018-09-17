//
//  HTTPBinManager.h
//  NSOperation
//
//  Created by Tingwei Hsu on 2018/9/17.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTTPBinManager;
@protocol HTTPBinManagerDelegate
- (void)managerDidStartOperation:(HTTPBinManager *)manager;
- (void)manager:(HTTPBinManager*)manager didFinishCurrentOperationWithGetDict:(NSDictionary*)getDict andPostDict:(NSDictionary*)postDict andImage:(UIImage*)image;
- (void)manager:(HTTPBinManager*)manager didEndCurrentOperationWithError:(NSError*)error;
- (void)manager:(HTTPBinManager*)manager didUpdateCurrentLoadingProgressPercentage:(NSInteger)percentage;
@end

@interface HTTPBinManager : NSObject
@property(nonatomic,weak) id<HTTPBinManagerDelegate> delegate;
+ (instancetype)sharedInstance;
- (void)executeOperation;
- (void)cancelOperation;
@end
