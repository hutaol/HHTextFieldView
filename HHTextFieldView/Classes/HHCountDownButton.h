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

typedef NSString * _Nullable (^CountDownChanging)(HHCountDownButton *countDownButton, NSUInteger second);
typedef NSString * _Nullable (^CountDownFinished)(HHCountDownButton *countDownButton, NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(HHCountDownButton *countDownButton, NSInteger tag);

@interface HHCountDownButton : UIButton

@property (nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;
@end

NS_ASSUME_NONNULL_END
