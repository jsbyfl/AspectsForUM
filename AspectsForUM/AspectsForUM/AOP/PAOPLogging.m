//
//  PAOPLogging.m
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import "PAOPLogging.h"
#import "PLoggingConfig.h"

static NSString * const  PAOPLoggingPageImpression    = @"PAOPLoggingPageImpression";
static NSString * const  PAOPLoggingTrackedEvents     = @"PAOPLoggingTrackedEvents";
static NSString * const  PAOPLoggingEventName         = @"PAOPLoggingEventName";
static NSString * const  PAOPLoggingEventSelectorName = @"PAOPLoggingEventSelectorName";
static NSString * const  PAOPLoggingEventHandlerBlock = @"PAOPLoggingEventHandlerBlock";


@implementation UIViewController (AOPLogging)

+ (NSDictionary *)loggingConfig
{
    NSString *pageImpression = [[self class] loggingPageImpression];
    NSArray *trackedEvents = [[self class] loggingTrackedEvents];
    if (!pageImpression && !trackedEvents) {
        NSLog(@"loggingConfig[%@] empty",NSStringFromClass([self class]));
        return @{};
    }

    NSMutableDictionary *loggingConfig = [NSMutableDictionary dictionary];
    if (pageImpression) {
        loggingConfig[PAOPLoggingPageImpression] = pageImpression;
    }

    if ([trackedEvents count] > 0) {
        loggingConfig[PAOPLoggingTrackedEvents] = trackedEvents;
    }

    return [loggingConfig copy];
}

+ (NSString *)loggingPageImpression
{
    return nil;
}

+ (NSArray *)loggingTrackedEvents
{
    return nil;
}

+ (NSDictionary *)eventId:(NSString *)eventId selector:(SEL)selector
{
    return [self eventId:eventId selectorName:NSStringFromSelector(selector) aspectBlock:nil];
}

+ (NSDictionary *)eventId:(NSString *)eventId selectorName:(NSString *)selectorName
{
    return [self eventId:eventId selectorName:selectorName aspectBlock:nil];
}

+ (NSDictionary *)eventId:(NSString *)eventId selectorName:(NSString *)selectorName aspectBlock:(AspectHandlerBlock)aspectBlock
{
    if (!aspectBlock) {
        aspectBlock = ^(id<AspectInfo> aspectInfo) {

#warning 传进来的block==nil,意思是 所有的方法调用在此处监听,可以实现UMeng统计

            //统计
            id instance = [aspectInfo instance];
            NSInvocation *invocation = [aspectInfo originalInvocation];
            NSArray *args = [aspectInfo arguments];


            NSLog(@"此处可以进行UMeng统计,该方法此时被调用 \n eventId = %@,\n selectorName = %@,\n hock的对象 = %@,\n invocation = %@, \n该方法的参数值列表 = %@",eventId,selectorName,instance,invocation,args);
        };
    }

    return @{
             PAOPLoggingEventName:eventId,
             PAOPLoggingEventSelectorName:selectorName,
             PAOPLoggingEventHandlerBlock:aspectBlock
             };
}

@end


#pragma mark -- PAOPLogging --
@implementation PAOPLogging
+ (void)setupUMengEvents
{
    NSDictionary *loggingConfig = [PLoggingConfig totalLoggingConfig];
    if (loggingConfig.allKeys.count == 0) {
        return;
    }

    [[self class] setupWithConfiguration:loggingConfig];
}


+ (void)setupWithConfiguration:(NSDictionary *)configs
{
    // Hook controller
    [[self class] registerControllerLifeCycle:configs];

    // Hook Events
    for (NSString *className in configs) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[className];

        if (config[PAOPLoggingTrackedEvents]) {
            for (NSDictionary *event in config[PAOPLoggingTrackedEvents]) {
                SEL selekor = NSSelectorFromString(event[PAOPLoggingEventSelectorName]);
                AspectHandlerBlock block = event[PAOPLoggingEventHandlerBlock];

                [clazz aspect_hookSelector:selekor
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    block(aspectInfo);
                                } error:NULL];
            }
        }
    }
}

//hock所有controller的生命周期函数
+ (void)registerControllerLifeCycle:(NSDictionary *)configs
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                       withOptions:AspectPositionBefore
                        usingBlock:^(id<AspectInfo>aspectInfo) {
                            //统计
                            UIViewController *controller = [aspectInfo instance];
#warning 此处监听controller viewWillAppear的调用
                            NSLog(@"Controller = %@,viewWillAppear方法被调用:",controller);

                        }error:NULL];
}

@end
