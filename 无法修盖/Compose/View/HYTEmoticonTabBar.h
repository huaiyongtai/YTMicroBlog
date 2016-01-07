//
//  HYTEmoticonTabBar.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTEmoticonTabBar;

typedef NS_ENUM(NSUInteger, HYTEmoticonTabBarItemType) {
    
    HYTEmoticonTabBarItemTypeRecency,
    HYTEmoticonTabBarItemTypeDefault,
    HYTEmoticonTabBarItemTypeEmoji,
    HYTEmoticonTabBarItemTypeLXH
};

@protocol HYTEmoticonTabBarDelegate <NSObject>

@optional
- (void)emoticonTabBar:(HYTEmoticonTabBar *)tabBar didSelectedItemBarType:(HYTEmoticonTabBarItemType)itemType;

@end

@interface HYTEmoticonTabBar : UIView

+ (instancetype)tabBar;

@property (nonatomic, weak) id<HYTEmoticonTabBarDelegate> delegate;

@end
