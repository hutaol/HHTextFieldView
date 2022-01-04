//
//  HHCountDownButton.m
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHCountDownButton.h"

@interface NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats;
@end


@interface HHCountDownButton() {
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
}

@end

@implementation HHCountDownButton

#pragma -mark touche action

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touched:(HHCountDownButton*)sender{
    if (self.touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.touchedCountDownButtonHandler(sender, sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond {
    _totalSecond = totalSecond;
    _second = totalSecond;
   
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer jkcd_scheduledTimerWithTimeInterval:1.0 block:^{
         typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf timerStart];
    } repeats:YES];
    
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart {
     double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    if (_second <= 0.0) {
        [self stopCountDown];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *title = [NSString stringWithFormat:@"%@%zd%@", self.beingTitlePrefix, self->_second, self.beingTitleSuffix];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            if (self.countDownChanging) {
                self.countDownChanging(self, self->_second);
            }
        });
    }
}

- (void)stopCountDown {
    if (_timer && [_timer respondsToSelector:@selector(isValid)] && [_timer isValid]) {
        [_timer invalidate];
        _second = _totalSecond;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:self.title forState:UIControlStateNormal];
            [self setTitle:self.title forState:UIControlStateDisabled];
            if (self.countDownFinished) {
                self.countDownFinished(self, self->_second);
            }
        });
    }
}

@end


@implementation NSTimer (JKCountDownBlocksSupport)

+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(jkcd_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)jkcd_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}
@end
