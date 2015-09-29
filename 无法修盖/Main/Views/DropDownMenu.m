//
//  DropDownMenu.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "DropDownMenu.h"

@interface DropDownMenu ()

@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation DropDownMenu


- (UIImageView *)containerView {
    
    if (_containerView == nil) {
        _containerView = [[UIImageView alloc] init];
        [_containerView setImage:[UIImage imageWithResizableVerticalImageName:@"popover_background"]];
        [_containerView setUserInteractionEnabled:YES];
        [self addSubview:_containerView];
    }
    return _containerView;
}

+ (instancetype)menu {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    self.containerView.width = contentView.width + 2*10;
    self.containerView.height = contentView.height + 2*10+3;
    
    contentView.x = 10;
    contentView.y = 13;
    
    [self.containerView addSubview:contentView];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    _contentViewController = contentViewController;
    _contentView = contentViewController.view;
}

- (void)showFromView:(UIView *)fromView {
    
    //显示本视图
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [self setFrame:window.bounds];
    [window addSubview:self];
    
    //调整内容位置
    //转换坐标系， 将以frameView自身的坐标系为坐标系 中的frame.bounds 转换window自身的坐标系
    CGRect newRect = [fromView convertRect:fromView.bounds toView:window];
    
    [self.containerView setY:CGRectGetMaxY(newRect)];
    [self.containerView setCenterX:CGRectGetMidX(newRect)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
