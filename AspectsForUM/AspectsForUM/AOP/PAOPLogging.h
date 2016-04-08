//
//  PAOPLogging.h
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);

@interface UIViewController (AOPLogging)

+ (NSDictionary *)loggingConfig;
+ (NSString *)loggingPageImpression;    //统计页面时的页面ID名称
+ (NSArray *)loggingTrackedEvents;      //事件列表

+ (NSDictionary *)eventId:(NSString *)eventId selector:(SEL)selector;
+ (NSDictionary *)eventId:(NSString *)eventId selectorName:(NSString *)selectorName;
+ (NSDictionary *)eventId:(NSString *)eventId selectorName:(NSString *)selectorName aspectBlock:(AspectHandlerBlock)aspectBlock;
@end


#pragma mark -- PAOPLogging --
@interface PAOPLogging : NSObject
+ (void)setupUMengEvents;
@end
