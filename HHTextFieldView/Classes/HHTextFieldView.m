//
//  HHTextFieldView.m
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHTextFieldView.h"
#import "HHPictureCodeView.h"
#import "HHCountDownButton.h"

@interface HHTextFieldView ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIView *underLineView;

@property (nonatomic, strong) HHPictureCodeView *picCodeView;
@property (nonatomic, strong) HHCountDownButton *countDownButton;

@end

@implementation HHTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textField];
    }
    return self;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    if (_leftTitle == leftTitle) {
        return;
    }
    _leftTitle = leftTitle;
    self.leftLabel.text = leftTitle;
    [self addSubview:self.leftLabel];

}

- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    if (_leftViewWidth == leftViewWidth) {
        return;
    }
    _leftViewWidth = leftViewWidth;
    [self setNeedsLayout];
}

- (void)setShowUnderLine:(BOOL)showUnderLine {
    if (_showUnderLine == showUnderLine) {
        return;
    }
    _showUnderLine = showUnderLine;
    if (showUnderLine) {
        [self addSubview:self.underLineView];
        [self setNeedsLayout];
    } else {
        [self.underLineView removeFromSuperview];
    }
}

- (void)setRightType:(HHTextFieldRightType)rightType {
    if (_rightType == rightType) {
        return;
    }
    _rightType = rightType;
    
    switch (rightType) {
        case HHTextFieldRightTypePictureCode:
        {
            // 图形
            [self addSubview:self.picCodeView];
        }
            break;
        case HHTextFieldRightTypeVerificationCode:
        {
            // 验证码
            [self addSubview:self.countDownButton];
        }
            break;
            
        default:
            break;
    }
    
    [self setNeedsLayout];
    
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat rightWidth = 100;
    
    BOOL showLeft = NO;
    BOOL showRight = NO;
    if (self.leftTitle.length > 0 && self.leftViewWidth > 0) {
        showLeft = YES;
        self.leftLabel.frame = CGRectMake(0, 0, self.leftViewWidth, self.frame.size.height);
    }
    
    if (self.rightType == HHTextFieldRightTypePictureCode) {
        self.picCodeView.frame = CGRectMake(self.frame.size.width - rightWidth, 10, rightWidth, self.frame.size.height-10);
        showRight = YES;
        
    } else if (self.rightType == HHTextFieldRightTypeVerificationCode) {
        self.countDownButton.frame = CGRectMake(self.frame.size.width - rightWidth, 10, rightWidth, self.frame.size.height-10);
        showRight = YES;

    }
    
    CGRect frame = self.bounds;
    if (showLeft) {
        frame.origin.x = self.leftViewWidth;
        frame.size.width -= self.leftViewWidth;
    }
    if (showRight) {
        frame.size.width = frame.size.width - rightWidth - 10;
    }
    
    self.textField.frame = frame;

    if (self.showUnderLine) {
        self.underLineView.frame = CGRectMake(0, frame.size.height-0.5, showLeft ? frame.size.width + self.leftViewWidth : frame.size.width , 0.5);
    }
}

- (void)onClickCountDown:(HHCountDownButton *)sender {
    
    if (self.verificationCodeViewCallBack) {
        self.verificationCodeViewCallBack();
    }
    
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:10];

    [sender countDownChanging:^NSString * _Nullable(HHCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒", second];
        return title;
    }];
    [sender countDownFinished:^NSString * _Nullable(HHCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"获取验证码";
    }];

}

#pragma mark -

- (void)setPictureCode:(UIImage *)image {
    if (self.rightType == HHTextFieldRightTypePictureCode) {
        [self.picCodeView setPictureCode:image];
    }
}

#pragma mark -

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
    }
    return _leftLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (UIView *)underLineView {
    if (!_underLineView) {
        _underLineView = [[UIView alloc] init];
        _underLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _underLineView;
}

- (HHPictureCodeView *)picCodeView {
    if (!_picCodeView) {
        _picCodeView = [[HHPictureCodeView alloc] init];
        _picCodeView.callBack = self.pictureCodeViewCallBack;;
    }
    return _picCodeView;
}

- (HHCountDownButton *)countDownButton {
    if (!_countDownButton) {
        _countDownButton = [[HHCountDownButton alloc] init];
        _countDownButton.layer.cornerRadius = 5;
        _countDownButton.backgroundColor = [UIColor redColor];
        [_countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];

        [_countDownButton addTarget:self action:@selector(onClickCountDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countDownButton;
}

@end
