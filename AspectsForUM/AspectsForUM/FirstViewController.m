//
//  FirstViewController.m
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test01_method:@"firstVCname001"];
    [self test02_method:@"firstVCname021" name2:@"firstVCname022" array:@[@1,@2,@3]];
}

- (IBAction)push:(id)sender {
    SecondViewController *vc = [[SecondViewController alloc] initWithNibName:NSStringFromClass([SecondViewController class]) bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test01Events:(id)sender {
    [self test01_method:@"按钮点击firstVCname001"];
}
- (IBAction)test02Events:(id)sender {
    [self test02_method:@"按钮点击firstVCname021" name2:@"按钮点击firstVCname022" array:@[@01,@02,@03]];
}


- (void)test01_method:(NSString *)name
{

}

- (void)test02_method:(NSString *)name1 name2:(NSString *)name2 array:(NSArray *)array
{

}

@end
