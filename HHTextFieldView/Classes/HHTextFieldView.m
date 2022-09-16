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

@property (nonatomic, strong) UIButton *secureButton;

@property (nonatomic, assign) BOOL countDownBeing;

@end

@implementation HHTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithRightType:(HHTextFieldRightType)rightType {
    self = [super init];
    if (self) {
        self.rightType = rightType;
    }
    return self;
}

- (void)initialize {
    [self addSubview:self.textField];
}

- (UIImage *)imageWithSecureOpen {
    return self.secureOpenImage ?: [self imageWithName:@"HHTextFieldView_secure_open"];
}

- (UIImage *)imageWithSecureClose {
    return self.secureCloseImage ?: [self imageWithName:@"HHTextFieldView_secure_close"];
}

- (UIImage *)imageWithName:(NSString *)name {
     NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *image = [UIImage imageWithContentsOfFile:[[bundle resourcePath] stringByAppendingPathComponent:name]];
    return image;
}

- (void)setOnClickCallback:(HHTextFieldViewClickCallBack)onClickCallback {
    if (_onClickCallback == onClickCallback) {
        return;
    }
    _onClickCallback = onClickCallback;
    if (onClickCallback) {
        self.textField.enabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onClick:)];
        [self addGestureRecognizer:tap];
    }
}

- (void)onClick:(UITapGestureRecognizer *)sender {
    if (self.onClickCallback) {
        self.onClickCallback(self);
    }
}



#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 100
    CGFloat rightWidth = self.rightViewWidth;
    CGFloat rightMargin = 10;
    
    BOOL showLeft = NO;
    BOOL showRight = NO;
    if (self.leftTitle.length > 0 && self.leftViewWidth > 0) {
        showLeft = YES;
        self.leftLabel.frame = CGRectMake(self.edgeInsets.left, self.edgeInsets.top, self.leftViewWidth, self.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
    }
    
    if (self.rightType == HHTextFieldRightTypePictureCode) {
        
        if (rightWidth <= 0) {
            rightWidth = 100;
        }
        
        if (self.showUnderLine) {
            self.picCodeView.frame = CGRectMake(self.frame.size.width - rightWidth - self.edgeInsets.right, 10 + self.edgeInsets.top, rightWidth, self.frame.size.height-10 - self.edgeInsets.top - self.edgeInsets.bottom);
        } else {
            self.picCodeView.frame = CGRectMake(self.frame.size.width - rightWidth - self.edgeInsets.right, self.edgeInsets.top, rightWidth, self.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
        }
        showRight = YES;
        
    } else if (self.rightType == HHTextFieldRightTypeVerificationCode) {
        
        if (rightWidth <= 0) {
            [self.countDownButton sizeToFit];
            rightWidth = self.countDownButton.frame.size.width + 10;
        }
        
        if (self.showUnderLine) {
            self.countDownButton.frame = CGRectMake(self.frame.size.width - rightWidth - self.edgeInsets.right, 10 + self.edgeInsets.top, rightWidth, self.frame.size.height-10 - self.edgeInsets.top - self.edgeInsets.bottom);
        } else {
            self.countDownButton.frame = CGRectMake(self.frame.size.width - rightWidth - self.edgeInsets.right, self.edgeInsets.top, rightWidth, self.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
        }
        showRight = YES;

    } else if (self.rightType == HHTextFieldRightTypeSecure) {
        rightMargin = 0;
        rightWidth = self.frame.size.height;
        self.secureButton.frame = CGRectMake(self.frame.size.width - rightWidth, 0, self.frame.size.height, self.frame.size.height);
        showRight = YES;
    }
    
    CGRect frame = self.bounds;
    if (showLeft) {
        frame.origin.x = self.leftViewWidth;
        frame.size.width -= self.leftViewWidth;
    }
    if (showRight) {
        frame.size.width = frame.size.width - rightWidth - rightMargin;
    }
    
    frame.origin.x += self.textFieldInsets.left + self.edgeInsets.left;
    frame.size.width -= (self.textFieldInsets.left + self.textFieldInsets.right + self.edgeInsets.left + self.edgeInsets.right);

    self.textField.frame = frame;

    if (self.showUnderLine) {
        if (self.underLineFull) {
            self.underLineView.frame = CGRectMake(0, frame.size.height - 0.5, self.frame.size.width , 0.5);
        } else {
            self.underLineView.frame = CGRectMake(0, frame.size.height - 0.5, showLeft ? frame.size.width + self.leftViewWidth : frame.size.width , 0.5);
        }
    }
}

#pragma mark - Setter

- (void)setLeftTitle:(NSString *)leftTitle {
    if (_leftTitle == leftTitle) {
        return;
    }
    _leftTitle = leftTitle;
    self.leftLabel.text = leftTitle;
    [self addSubview:self.leftLabel];

}

- (void)setLeftTitleColor:(UIColor *)leftTitleColor {
    if (_leftTitleColor == leftTitleColor) {
        return;
    }
    _leftTitleColor = leftTitleColor;
    self.leftLabel.textColor = leftTitleColor;
}

- (void)setLeftTitleFont:(UIFont *)leftTitleFont {
    if (_leftTitleFont == leftTitleFont) {
        return;
    }
    _leftTitleFont = leftTitleFont;
    self.leftLabel.font = leftTitleFont;
}

- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    if (_leftViewWidth == leftViewWidth) {
        return;
    }
    _leftViewWidth = leftViewWidth;
    [self setNeedsLayout];
}

- (void)setRightViewWidth:(CGFloat)rightViewWidth {
    if (_rightViewWidth == rightViewWidth) {
        return;
    }
    _rightViewWidth = rightViewWidth;
    [self setNeedsLayout];
}

- (void)setTextFieldInsets:(UIEdgeInsets)textFieldInsets {
    _textFieldInsets = textFieldInsets;
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

- (void)setUnderLineColor:(UIColor *)underLineColor {
    _underLineColor = underLineColor;
    self.underLineView.backgroundColor = underLineColor;
}

- (void)setUnderLineFull:(BOOL)underLineFull {
    _underLineFull = underLineFull;
    [self setNeedsLayout];
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
            self.countDownBeingTitlePrefix = @"剩余";
            self.countDownBeingTitleSuffix = @"秒";
            self.countDownTitle = @"获取验证码";
        }
            break;
        case HHTextFieldRightTypeArrow:
        {
            // 箭头
            UIImage *image = [self imageWithName:@"HHTextFieldView_arrow_right"];

            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            self.textField.rightView = imageView;
            self.textField.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case HHTextFieldRightTypeSecure:
        {
            // 安全密码
//            self.textField.rightView = self.secureButton;
//            self.textField.rightViewMode = UITextFieldViewModeAlways;
            self.textField.secureTextEntry = YES;
            [self addSubview:self.secureButton];
        }
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
    
}

- (void)setPictureCode:(UIImage *)image {
    if (self.rightType == HHTextFieldRightTypePictureCode) {
        [self.picCodeView setPictureCode:image];
    }
}

/// Secure
- (void)setSecureOpenImage:(UIImage *)secureOpenImage {
    _secureOpenImage = secureOpenImage;
    if (self.rightType == HHTextFieldRightTypeSecure && self.secureButton.selected == YES) {
        [self.secureButton setImage:[self imageWithSecureOpen] forState:UIControlStateNormal];
    }
}

- (void)setSecureCloseImage:(UIImage *)secureCloseImage {
    _secureCloseImage = secureCloseImage;
    if (self.rightType == HHTextFieldRightTypeSecure && self.secureButton.selected == NO) {
        [self.secureButton setImage:[self imageWithSecureClose] forState:UIControlStateNormal];
    }
}

- (void)setCountDownEnable:(BOOL)countDownEnable {
    if (self.countDownBeing) {
        return;
    }
    _countDownEnable = countDownEnable;
    self.countDownButton.enabled = countDownEnable;
    if (countDownEnable) {
        if (self.countDownBackgroundColor) {
            self.countDownButton.backgroundColor = self.countDownBackgroundColor;
        }
        if (self.countDownTitleColor) {
            [self.countDownButton setTitleColor:self.countDownTitleColor forState:UIControlStateNormal];
        }
    } else {
        if (self.unable_countDownBackgroundColor) {
            self.countDownButton.backgroundColor = self.unable_countDownBackgroundColor;
        }
        if (self.unable_countDownTitleColor) {
            [self.countDownButton setTitleColor:self.unable_countDownTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setCountDownBackgroundColor:(UIColor *)countDownBackgroundColor {
    _countDownBackgroundColor = countDownBackgroundColor;
    self.countDownButton.backgroundColor = self.countDownBackgroundColor;
}

- (void)setUnable_countDownBackgroundColor:(UIColor *)unable_countDownBackgroundColor {
    _unable_countDownBackgroundColor = unable_countDownBackgroundColor;
}

- (void)setCountDownTitleColor:(UIColor *)countDownTitleColor {
    _countDownTitleColor = countDownTitleColor;
    [self.countDownButton setTitleColor:countDownTitleColor forState:UIControlStateNormal];
}

- (void)setUnable_countDownTitleColor:(UIColor *)unable_countDownTitleColor {
    _unable_countDownTitleColor = unable_countDownTitleColor;
}

- (void)setCountDownTitleFont:(UIFont *)countDownTitleFont {
    _countDownTitleFont = countDownTitleFont;
    self.countDownButton.titleLabel.font = countDownTitleFont;
}

- (void)setCountDownBeingTitlePrefix:(NSString *)countDownBeingTitlePrefix {
    _countDownBeingTitlePrefix = countDownBeingTitlePrefix;
    self.countDownButton.beingTitlePrefix = countDownBeingTitlePrefix;
}

- (void)setCountDownBeingTitleSuffix:(NSString *)countDownBeingTitleSuffix {
    _countDownBeingTitleSuffix = countDownBeingTitleSuffix;
    self.countDownButton.beingTitleSuffix = countDownBeingTitleSuffix;
}

- (void)setCountDownTitle:(NSString *)countDownTitle {
    _countDownTitle = countDownTitle;
    [self.countDownButton setTitle:countDownTitle?:@"获取验证码" forState:UIControlStateNormal];
    self.countDownButton.title = countDownTitle;
}

#pragma mark - CountDown

- (void)startCountDown {
    [self startCountDown:0];
}

- (void)startCountDown:(NSInteger)secound {
    
    if (secound <= 0) {
        secound = 60;
    }
    
    self.countDownEnable = NO;
    self.countDownBeing = YES;
    
    // button type要 设置成custom 否则会闪动
    [self.countDownButton startCountDownWithSecond:secound];
    
    __weak typeof(self) weakSelf = self;
    self.countDownButton.countDownFinished = ^(HHCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        weakSelf.countDownBeing = NO;
        weakSelf.countDownEnable = YES;
    };
}

- (void)stopCountDown {
    [self.countDownButton stopCountDown];
}

#pragma mark - Action

/// 点击倒计时
- (void)onClickCountDown:(HHCountDownButton *)sender {
    if (self.verificationCodeViewCallBack) {
        self.verificationCodeViewCallBack(self);
    }
}

/// 点击安全密码
- (void)onClickSecure:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = !sender.selected;
    
    if (sender.selected) {
        [sender setImage:[self imageWithSecureOpen] forState:UIControlStateNormal];
    } else {
        [sender setImage:[self imageWithSecureClose] forState:UIControlStateNormal];
    }
}

#pragma mark - Lazy

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
        [_countDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_countDownButton addTarget:self action:@selector(onClickCountDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countDownButton;
}

- (UIButton *)secureButton {
    if (!_secureButton) {
        _secureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secureButton setImage:[self imageWithSecureClose] forState:UIControlStateNormal];
        [_secureButton addTarget:self action:@selector(onClickSecure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secureButton;
}

@end
