//
//  PLoggingConfig.m
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import "PLoggingConfig.h"
#import "PAOPLogging.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation PLoggingConfig

+ (NSDictionary *)totalLoggingConfig
{
    NSDictionary *configDic = @{NSStringFromClass([FirstViewController class]):
                                    [FirstViewController loggingConfig],
                                NSStringFromClass([SecondViewController class]):    [SecondViewController loggingConfig],
                            };
    return configDic;
}

@end


#pragma mark -- FirstViewController --
static NSString * const  k_FirstController_test01_Id    = @"k_FirstController_test01_Id";
static NSString * const  k_FirstController_test02_Id    = @"k_FirstController_test02_Id";
@interface FirstViewController (AOPLogging)
@end

@implementation FirstViewController (AOPLogging)

+ (NSString *)loggingPageImpression{
    return @"FirstViewControllerPage";
}

+ (NSArray *)loggingTrackedEvents
{
    NSDictionary *test01 = [[self class] eventId:k_FirstController_test01_Id selectorName:@"test01_method:"];

    NSDictionary *test02 = [[self class] eventId:k_FirstController_test02_Id selectorName:@"test02_method:name2:array:" aspectBlock:^(id<AspectInfo> aspectInfo) {

#warning 在此处实现block,相当于该事件单独处理
        //统计
        id instance = [aspectInfo instance];
        NSArray *args = [aspectInfo arguments];
        NSLog(@"相当于该事件单独处理，此处UMeng统计,该方法此时被调用 ,\n hock的对象 = %@,\n该方法的参数值列表 = %@",instance,args);
    }];

    return @[test01,test02];
}

@end


#pragma mark -- SecondViewController --
static NSString * const  k_SecondViewController_test01_Id    = @"k_SecondViewController_test01_Id";
static NSString * const  k_SecondViewController_test02_Id    = @"k_SecondViewController_test02_Id";
@interface SecondViewController (AOPLogging)
@end

@implementation SecondViewController (AOPLogging)

+ (NSString *)loggingPageImpression{
    return @"SecondViewControllerPage";
}

+ (NSArray *)loggingTrackedEvents
{
    NSDictionary *test01 = [[self class] eventId:k_FirstController_test01_Id selectorName:@"secondVCtest01_method:"];

    NSDictionary *test02 = [[self class] eventId:k_FirstController_test02_Id selectorName:@"secondVCtest02_method:name2:array:"];

    return @[test01,test02];
}

@end
