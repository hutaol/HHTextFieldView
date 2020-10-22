//
//  HHViewController.m
//  HHTextFieldView
//
//  Created by 1325049637@qq.com on 10/22/2020.
//  Copyright (c) 2020 1325049637@qq.com. All rights reserved.
//

#import "HHViewController.h"
#import <HHTextFieldView/HHTextFieldView.h>

@interface HHViewController ()

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HHTextFieldView *view = [[HHTextFieldView alloc] init];
    view.rightType = HHTextFieldRightTypeArrow;
    view.leftTitle = @"111";
    view.leftViewWidth = 100;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 100, 300, 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
