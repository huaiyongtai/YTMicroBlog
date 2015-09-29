//
//  YTTabBar.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "YTTabBar.h"

@interface YTTabBar ()

//tabBar中间的加号按钮
@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation YTTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        UITableView
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"]
                           forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"]
                           forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"]
                 forState:UIControlStateNormal];
        [plusBtn setSize:plusBtn.currentBackgroundImage.size];
        
        [plusBtn addTarget:self
                    action:@selector(plusBtnDidClick)
          forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;

        [self addSubview:plusBtn];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    //先让tabBar布局
    [super layoutSubviews];
    
    //自己在重新布局
    
    //center是相对父控件的
    [self.plusBtn setCenter:CGPointMake(self.width*0.5, self.height*0.5)];
    
    //布局tabBar内的UITabBarButton
    CGFloat tabBarWidth = self.width / 5;
    NSInteger tabBarItemIndex = 0;
    Class tabBarItemClass = NSClassFromString(@"UITabBarButton");   //tabBar内的UITabBarButton是Apple私有的，故只能这样声明类
    
    for (UIView *item in [self subviews]) {
        if ([item isKindOfClass:tabBarItemClass]) {
            item.x = tabBarWidth * tabBarItemIndex;
            tabBarItemIndex++;
        }
        
        if (tabBarItemIndex == 2) {
            tabBarItemIndex++;
        }
    }

}

- (void)plusBtnDidClick {
    if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedPlusBtn:)]) {
        [self.delegate tabBarDidSelectedPlusBtn:self];
    }
}

@end
