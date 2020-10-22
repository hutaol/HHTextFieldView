//
//  HHTextFieldView.h
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPictureCodeView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHTextFieldRightType) {
    HHTextFieldRightTypeNone,
    HHTextFieldRightTypePictureCode,        // 图形码
    HHTextFieldRightTypeVerificationCode,   // 验证码
};

typedef void(^HHVerificationCodeViewCallBack)(void);


@interface HHTextFieldView : UIView

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, assign) CGFloat leftViewWidth;

@property (nonatomic, assign) BOOL showUnderLine;

@property (nonatomic, assign) HHTextFieldRightType rightType;

@property (nonatomic, copy) HHPictureCodeViewCallBack pictureCodeViewCallBack;

@property (nonatomic, copy) HHVerificationCodeViewCallBack verificationCodeViewCallBack;

// HHTextFieldRightTypePictureCode有效
- (void)setPictureCode:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
