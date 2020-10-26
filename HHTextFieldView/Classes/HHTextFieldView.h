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
    HHTextFieldRightTypePictureCode,        // 图形码
    HHTextFieldRightTypeVerificationCode,   // 验证码
    HHTextFieldRightTypeArrow,              // 箭头
};

typedef void(^HHVerificationCodeViewCallBack)(HHTextFieldView *view);
typedef void(^HHTextFieldViewClickCallBack)(HHTextFieldView *view);

@interface HHTextFieldView : UIView

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, strong) UIColor *leftTitleColor;
@property (nonatomic, strong) UIFont *leftTitleFont;

@property (nonatomic, assign) CGFloat leftViewWidth;

@property (nonatomic, assign) BOOL showUnderLine;

@property (nonatomic, assign) HHTextFieldRightType rightType;

// 设置这个点击后 textField就不可编辑
@property (nonatomic, copy) HHTextFieldViewClickCallBack onClickCallback;
@property (nonatomic, copy) HHPictureCodeViewCallBack pictureCodeViewCallBack;
@property (nonatomic, copy) HHVerificationCodeViewCallBack verificationCodeViewCallBack;

// 默认red
@property (nonatomic, strong) UIColor *countDownBackgroundColor;
@property (nonatomic, strong) UIColor *unable_countDownBackgroundColor;
@property (nonatomic, assign) BOOL countDownEnable;
@property (nonatomic, copy) NSString *countDownTitle;

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

@end

NS_ASSUME_NONNULL_END
