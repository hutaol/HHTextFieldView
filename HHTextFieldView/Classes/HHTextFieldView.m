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

- (void)setTextFieldHorizontalMargin:(CGFloat)textFieldHorizontalMargin {
    if (_textFieldHorizontalMargin == textFieldHorizontalMargin) {
        return;
    }
    _textFieldHorizontalMargin = textFieldHorizontalMargin;
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
        case HHTextFieldRightTypeArrow:
        {
            // 箭头
            NSString *path = [self getResourcePath:@"right_arrow"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];

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

- (UIImage *)imageWithSecureOpen {
    return self.secureOpenImage ?: [UIImage imageWithContentsOfFile:[self getResourcePath:@"secure_open"]];
}

- (UIImage *)imageWithSecureClose {
    return self.secureCloseImage ?: [UIImage imageWithContentsOfFile:[self getResourcePath:@"secure_close"]];
}

- (NSBundle *)getResourceBundle:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    if (!resourceBundle) {
        NSString * bundlePath = [bundle.resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", bundleName]];
        resourceBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return resourceBundle ?: bundle;
}

- (NSString *)getResourcePath:(NSString *)name {
    return [[[self getResourceBundle:@"HHTextFieldView"] resourcePath] stringByAppendingPathComponent:name];
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

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat rightWidth = 100;
    CGFloat rightMargin = 10;
    
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
    
    frame.origin.x += self.textFieldHorizontalMargin;
    frame.size.width -= self.textFieldHorizontalMargin * 2;

    self.textField.frame = frame;

    if (self.showUnderLine) {
        self.underLineView.frame = CGRectMake(0, frame.size.height - 0.5, showLeft ? frame.size.width + self.leftViewWidth : frame.size.width , 0.5);
    }
}

- (void)onClickCountDown:(HHCountDownButton *)sender {
    
    if (self.verificationCodeViewCallBack) {
        self.verificationCodeViewCallBack(self);
    }

}

- (void)startCountDown {
    [self startCountDown:0];
}

- (void)startCountDown:(NSInteger)secound {
    
    if (secound <= 0) {
        secound = 60;
    }
    
    self.countDownButton.enabled = NO;
    self.countDownEnable = NO;
    
    //button type要 设置成custom 否则会闪动
    [self.countDownButton startCountDownWithSecond:secound];

    [self.countDownButton countDownChanging:^NSString * _Nullable(HHCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒", second];
        return title;
    }];
    [self.countDownButton countDownFinished:^NSString * _Nullable(HHCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        self.countDownEnable = YES;
        return self.countDownTitle?:@"获取验证码";
    }];
}

- (void)stopCountDown {
    [self.countDownButton stopCountDown];
}

- (void)setCountDownEnable:(BOOL)countDownEnable {
    _countDownEnable = countDownEnable;
    if (countDownEnable) {
        self.countDownButton.backgroundColor = self.countDownBackgroundColor ?: [UIColor redColor];
    } else {
        self.countDownButton.backgroundColor = self.unable_countDownBackgroundColor ?: [UIColor redColor];
    }
}

- (void)setCountDownBackgroundColor:(UIColor *)countDownBackgroundColor {
    _countDownBackgroundColor = countDownBackgroundColor;
}

- (void)setUnable_countDownBackgroundColor:(UIColor *)unable_countDownBackgroundColor {
    _unable_countDownBackgroundColor = unable_countDownBackgroundColor;
}

- (void)setCountDownTitle:(NSString *)countDownTitle {
    _countDownTitle = countDownTitle;
    [self.countDownButton setTitle:countDownTitle?:@"获取验证码" forState:UIControlStateNormal];
}

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

- (UIButton *)secureButton {
    if (!_secureButton) {
        _secureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secureButton setImage:[self imageWithSecureClose] forState:UIControlStateNormal];
        [_secureButton addTarget:self action:@selector(onClickSecure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secureButton;
}

@end
