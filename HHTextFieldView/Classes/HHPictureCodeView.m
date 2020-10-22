//
//  HHPictureCodeView.m
//  YYT
//
//  Created by Henry on 2020/10/10.
//  Copyright © 2020 eastraycloud. All rights reserved.
//

#import "HHPictureCodeView.h"

@interface HHPictureCodeView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation HHPictureCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.imageView];
        [self addSubview:self.maskView];
        [self addSubview:self.loadingView];
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.loadingView.isAnimating) {
        return;
    }
    self.maskView.hidden = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.loadingView.isAnimating) {
        return;
    }
    self.maskView.hidden = YES;
    [self startAnimating];
    
    if (self.callBack) {
        self.callBack(self);
    }
}

- (void)startAnimating {
    if (self.loadingView.isAnimating) {
        return;
    }
    [self.loadingView startAnimating];
//    self.userInteractionEnabled = NO;
}

- (void)stopAnimating {
    [self.loadingView stopAnimating];
//    self.userInteractionEnabled = YES;
}

- (void)setPictureCode:(UIImage *)image {
    if (image) {
        self.imageView.image = image;
    }
    [self stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.imageView.frame = frame;
    self.maskView.frame = frame;
    self.loadingView.frame = frame;
}


#pragma mark - Getters

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] init];
        _loadingView.hidesWhenStopped = YES;
    }
    return _loadingView;
}

@end
