//
//  HHTextFieldView.h
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPictureCodeView.h"
@class HHTextFieldView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHTextFieldRightType) {
    HHTextFieldRightTypeNone,
    HHTextFieldRightTypePictureCode,        ///< 图形码
    HHTextFieldRightTypeVerificationCode,   ///< 验证码
    HHTextFieldRightTypeArrow,              ///< 箭头
    HHTextFieldRightTypeSecure,             ///< 安全
};

typedef void(^HHVerificationCodeViewCallBack)(HHTextFieldView *view);
typedef void(^HHTextFieldViewClickCallBack)(HHTextFieldView *view);

@interface HHTextFieldView : UIView

@property (nonatomic, strong) UITextField *textField;

/// 左边视图 左边标题和宽度同时设置才有效
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, strong) UIColor *leftTitleColor;
@property (nonatomic, strong) UIFont *leftTitleFont;
@property (nonatomic, assign) CGFloat leftViewWidth;

/// 下划线是否展示
@property (nonatomic, assign) BOOL showUnderLine;

/// 右边显示类型
@property (nonatomic, assign) HHTextFieldRightType rightType;

/// 输入框水平间距 默认：0
@property (nonatomic, assign) CGFloat textFieldHorizontalMargin;

/// 设置这个点击后 textField就不可编辑
@property (nonatomic, copy) HHTextFieldViewClickCallBack onClickCallback;
@property (nonatomic, copy) HHPictureCodeViewCallBack pictureCodeViewCallBack;
@property (nonatomic, copy) HHVerificationCodeViewCallBack verificationCodeViewCallBack;

// 默认red
@property (nonatomic, strong) UIColor *countDownBackgroundColor;
@property (nonatomic, strong) UIColor *unable_countDownBackgroundColor;
@property (nonatomic, assign) BOOL countDownEnable;
@property (nonatomic, copy) NSString *countDownTitle;

// Secure
@property (nonatomic, strong) UIImage *secureOpenImage;
@property (nonatomic, strong) UIImage *secureCloseImage;

@end


// HHTextFieldRightTypePictureCode有效
@interface HHTextFieldView (PictureCode)

- (void)setPictureCode:(UIImage *)image;

@end


// HHTextFieldRightTypeVerificationCode有效
@interface HHTextFieldView (CountDown)

// 默认60s
- (void)startCountDown;
- (void)startCountDown:(NSInteger)secound;
- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
