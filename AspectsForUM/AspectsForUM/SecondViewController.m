//
//  SecondViewController.m
//  AspectsForUM
//
//  Created by lpc on 16/4/8.
//  Copyright © 2016年 lpc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)pop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)test01Click:(id)sender {
    [self secondVCtest01_method:@"secondVCName001"];
}

- (IBAction)test02Click:(id)sender {
    [self secondVCtest02_method:@"secondVCName001" name2:@"secondVCName002" array:@[@1,@2,@3,@4,@5,@6,@7,@8]];
}


- (void)secondVCtest01_method:(NSString *)name
{

}

- (void)secondVCtest02_method:(NSString *)name1 name2:(NSString *)name2 array:(NSArray *)array
{
    
}


@end
