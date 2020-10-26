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
    view.rightType = HHTextFieldRightTypeVerificationCode;
    view.textField.text = @"验证码";
    [self.view addSubview:view];
    view.showUnderLine = YES;
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 100, 300, 50);
    view.verificationCodeViewCallBack = ^(HHTextFieldView * _Nonnull view) {
        [view startCountDown];
    };
    view.countDownBackgroundColor = [UIColor blueColor];
    view.unable_countDownBackgroundColor = [UIColor yellowColor];
    view.countDownEnable = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
