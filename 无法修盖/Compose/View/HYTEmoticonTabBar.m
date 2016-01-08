//
//  HYTEmoticonTabBar.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonTabBar.h"
#import "HYTEmoticonTabBarItem.h"

@interface HYTEmoticonTabBar ()

@property (nonatomic, strong) NSMutableArray *tabBars;

@property (nonatomic, weak) UIButton *lastTabBarItem;

@end


@implementation HYTEmoticonTabBar

+ (instancetype)tabBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _tabBars = [NSMutableArray array];
        
        [self setBackgroundColor:HYTCOLORANDOM];
        
        [self addTabBarItemWithTitle:@"最近" itemType:HYTEmoticonTabBarItemTypeRecency];
        [self addTabBarItemWithTitle:@"默认" itemType:HYTEmoticonTabBarItemTypeDefault];
        [self addTabBarItemWithTitle:@"Emoji" itemType:HYTEmoticonTabBarItemTypeEmoji];
        [self addTabBarItemWithTitle:@"浪小花" itemType:HYTEmoticonTabBarItemTypeLXH];
    }
    return self;
}


- (void)addTabBarItemWithTitle:(NSString *)title itemType:(HYTEmoticonTabBarItemType)itemType {
    
    UIButton *tabBarItem = [HYTEmoticonTabBarItem buttonWithType:UIButtonTypeCustom];
    [tabBarItem setTitle:title forState:UIControlStateNormal];
    [tabBarItem setTag:itemType];
    [tabBarItem addTarget:self action:@selector(emoticonSwithItemDidSelected:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarItem];
    [self.tabBars addObject:tabBarItem];
    
    if (itemType == HYTEmoticonTabBarItemTypeDefault) {
        [self emoticonSwithItemDidSelected:tabBarItem];
    }
}

- (void)setDelegate:(id<HYTEmoticonTabBarDelegate>)delegate {
    
    _delegate = delegate;
    [self emoticonSwithItemDidSelected:self.lastTabBarItem];
}

- (void)emoticonSwithItemDidSelected:(UIButton *)tabBarItem {
    
    [self.lastTabBarItem setEnabled:YES];
    [tabBarItem setEnabled:NO];
    self.lastTabBarItem = tabBarItem;
    if ([self.delegate respondsToSelector:@selector(emoticonTabBar:didSelectedItemBarType:)]) {
        [self.delegate emoticonTabBar:self didSelectedItemBarType:tabBarItem.tag];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSArray *tabBars = self.tabBars;
    CGFloat tabBarItemWidth = self.width / tabBars.count;
    [tabBars enumerateObjectsUsingBlock:^(UIView *tabBarItem, NSUInteger idx, BOOL *stop) {
        [tabBarItem setFrame:CGRectMake(idx *tabBarItemWidth, 0, tabBarItemWidth, self.height)];
    }];
}

@end
