//
//  DropDownMenu.h
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownMenu : UIView

/**
 *  需要显示的内容
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  要显示内容的视图控制器
 */
@property (nonatomic, strong) UIViewController *contentViewController;

+ (instancetype)menu;

/**
 *  销毁下拉菜单
 */
- (void)dismiss;

/**
 *  根据frameView的位置来显示下拉菜单
 *
 *  @param fromView 在那个view下显示
 */
- (void)showFromView:(UIView *)fromView;



@end
