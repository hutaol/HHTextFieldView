//
//  HHPictureCodeView.h
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHPictureCodeView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^HHPictureCodeViewCallBack)(HHPictureCodeView *codeView);

@interface HHPictureCodeView : UIView

@property (nonatomic, copy) HHPictureCodeViewCallBack callBack;

- (void)startAnimating;
- (void)stopAnimating;

- (void)setPictureCode:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
