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
    
    [self addCodeUI1];
    [self addCodeUI2];
    [self addSecureUI];
    [self addArrayUI];
}

- (void)addCodeUI1 {
    HHTextFieldView *view = [[HHTextFieldView alloc] init];
    view.rightType = HHTextFieldRightTypeVerificationCode;
    view.textField.placeholder = @"验证码";
    [self.view addSubview:view];
    view.showUnderLine = YES;
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(20, 100, 300, 50);
    view.verificationCodeViewCallBack = ^(HHTextFieldView * _Nonnull view) {
        [view startCountDown:5];
    };
    view.countDownBackgroundColor = [UIColor blueColor];
    view.unable_countDownBackgroundColor = [UIColor yellowColor];
    view.countDownEnable = YES;
}

- (void)addCodeUI2 {
    HHTextFieldView *view = [[HHTextFieldView alloc] initWithRightType:HHTextFieldRightTypeVerificationCode];
    view.textField.placeholder = @"验证码";
    view.textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    view.layer.cornerRadius = 25;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(20, 200, 300, 50);
    view.verificationCodeViewCallBack = ^(HHTextFieldView * _Nonnull view) {
        [view startCountDown:5];
    };
    view.countDownEnable = YES;
    view.textFieldInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    view.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    view.countDownTitleFont = [UIFont systemFontOfSize:15];

}

- (void)addSecureUI {
    HHTextFieldView *view = [[HHTextFieldView alloc] init];
    view.rightType = HHTextFieldRightTypeSecure;
    view.layer.cornerRadius = 25;
    view.textFieldInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    [self.view addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(20, 300, 300, 50);
}

- (void)addArrayUI {
    HHTextFieldView *view = [[HHTextFieldView alloc] init];
    view.rightType = HHTextFieldRightTypeArrow;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(20, 400, 300, 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
