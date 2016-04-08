//
//  AppDelegate.m
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import "AppDelegate.h"
#import "PAOPLogging.h"
#import "FirstViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


    FirstViewController *firstVC = [[FirstViewController alloc] initWithNibName:NSStringFromClass([FirstViewController class]) bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    self.window.rootViewController = nav;


    //AOP
    [PAOPLogging setupUMengEvents];


    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];

    return YES;
}

@end
