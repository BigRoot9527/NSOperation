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
- (void)managerDidFinishedCurrentOperation:(HTTPBinManager *)manager;
- (void)manager:(HTTPBinManager*)manager DidUpdateCurrentLoadingProgressPercentage:(NSInteger)percentage;
@end

@interface HTTPBinManager : NSObject
@property(nonatomic,strong,readonly) NSDictionary *getDictionary;
@property(nonatomic,strong,readonly) NSDictionary *postDictionary;
@property(nonatomic,strong,readonly) UIImage *getImage;
@property(nonatomic,strong,readonly) NSString *errorMassage;
@property(nonatomic,weak) id<HTTPBinManagerDelegate> delegate;
+ (instancetype)sharedInstance;
- (void)executeOperation;
- (void)cancelOperation;
@end
