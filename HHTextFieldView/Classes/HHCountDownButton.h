//
//  HHCountDownButton.h
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHCountDownButton;

NS_ASSUME_NONNULL_BEGIN

typedef void (^CountDownChanging)(HHCountDownButton *countDownButton, NSUInteger second);
typedef void (^CountDownFinished)(HHCountDownButton *countDownButton, NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(HHCountDownButton *countDownButton, NSInteger tag);

@interface HHCountDownButton : UIButton

@property (nonatomic, strong) id userInfo;

@property (nonatomic, copy) NSString *beingTitlePrefix;
@property (nonatomic, copy) NSString *beingTitleSuffix;
@property (nonatomic, copy) NSString *title;

/// 倒计时时间改变回调
@property (nonatomic, copy) CountDownChanging countDownChanging;
/// 倒计时结束回调
@property (nonatomic, copy) CountDownFinished countDownFinished;
/// 倒计时按钮点击回调
@property (nonatomic, copy) TouchedCountDownButtonHandler touchedCountDownButtonHandler;

/// 开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
/// 停止倒计时
- (void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
