//
//  HYTEmoticonKeyboardView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonKeyboardView.h"
#import "HYTEmoticonTabBar.h"
#import "HYTEmoticonListView.h"

@interface HYTEmoticonKeyboardView () <HYTEmoticonTabBarDelegate>

@property (nonatomic, weak) HYTEmoticonTabBar *tabBar;
@property (nonatomic, weak) HYTEmoticonListView *listView;
@end

@implementation HYTEmoticonKeyboardView

+ (instancetype)emoticonKeyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:HYTCOLORANDOM];

        HYTEmoticonTabBar *tabBar = [HYTEmoticonTabBar tabBar];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        HYTEmoticonListView *listView = [HYTEmoticonListView listView];
        [self addSubview:listView];
        self.listView = listView;
    }
    return self;
}

#pragma mark - HYTEmoticonTabBarDelegate
- (void)emoticonTabBar:(HYTEmoticonTabBar *)tabBar didSelectedItemBarType:(HYTEmoticonTabBarItemType)itemType {
    
    switch (itemType) {
        case HYTEmoticonTabBarItemTypeRecency: {
            
            break;
        }
        case HYTEmoticonTabBarItemTypeDefault: {
            
            break;
        }
        case HYTEmoticonTabBarItemTypeEmoji: {
            
            break;
        }
        case HYTEmoticonTabBarItemTypeLXH: {
            
            break;
        }
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat tabBarHeight = 37;
    [self.tabBar setFrame:CGRectMake(0, self.height-tabBarHeight, self.width, tabBarHeight)];
    [self.listView setFrame:CGRectMake(0, 0, self.width, self.tabBar.y)];
}

@end
