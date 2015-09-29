//
//  DropDownMenu.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "DropDownMenu.h"

@interface DropDownMenu ()

/**
 *  容器视图，用来将内容放在容器中
 */
@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation DropDownMenu


- (UIImageView *)containerView {
    
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] init];
        [containerView setImage:[UIImage imageWithResizableVerticalImageName:@"popover_background"]];
        //开启事件交互（容器内的内容肯定需要交互）
        [containerView setUserInteractionEnabled:YES];
        [self addSubview:containerView];
        _containerView = containerView;
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
    
    //内容距离容器的边距
    CGFloat margin = 8;
    
    //根据显示内容的大小，来调整容器的大小
    self.containerView.width = contentView.width + 2*margin;
    self.containerView.height = contentView.height + 2*margin+6;
    
    //矫正内容在容器的位置（容器有箭头不规则，我们要确保内容在容器的适当范围内）
    contentView.x = margin+0.5;
    contentView.y = margin+5;
    
    [self.containerView addSubview:contentView];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    _contentViewController = contentViewController;
    _contentView = contentViewController.view;
}

- (void)showFromView:(UIView *)fromView {
    
    //显示自身视图，即添加到window上
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [self setFrame:window.bounds];
    [window addSubview:self];
    
    //*****调整内容位置******//
    
    //转换坐标系， 将以frameView自身的坐标系为坐标系 中的frame.bounds 转换window自身的坐标系
    CGRect newRect = [fromView convertRect:fromView.bounds toView:window];
    //设置显示位置
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
