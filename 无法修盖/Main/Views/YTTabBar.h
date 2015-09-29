//
//  YTTabBar.h
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTabBar;

@protocol YTTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidSelectedPlusBtn:(YTTabBar *)tabBar;

@end


@interface YTTabBar : UITabBar

@property (nonatomic, assign) id<YTTabBarDelegate> delegate;

@end
