//
//  HYTComposeToolbar.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/4.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTComposeToolbar.h"

@interface HYTComposeToolbar ()

@property (nonatomic, strong) NSMutableArray *toolbarItems;

@end

@implementation HYTComposeToolbar

+ (instancetype)toolbar {

    return [[HYTComposeToolbar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _toolbarItems = [NSMutableArray array];
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]]];

        [self addItemBarWithImageName:@"compose_toolbar_picture"
                         identitiyTag:HYTComposeToolbarItemPicture];
        [self addItemBarWithImageName:@"compose_mentionbutton_background"
                         identitiyTag:HYTComposeToolbarItemMention];
        [self addItemBarWithImageName:@"compose_trendbutton_background"
                         identitiyTag:HYTComposeToolbarItemTrend];
        [self addItemBarWithImageName:@"compose_emoticonbutton_background"
                         identitiyTag:HYTComposeToolbarItemEmoticon];
        [self addItemBarWithImageName:@"compose_toolbar_more"
                         identitiyTag:HYTComposeToolbarItemMore];
        
    }
    return self;
}

- (void)addItemBarWithImageName:(NSString *)imageName
                   identitiyTag:(HYTComposeToolbarItemType)identitiyTag {
    
    NSString *highlightedImageName = [NSString stringWithFormat:@"%@_highlighted", imageName];
    
    UIButton *itemBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBar setImage:[UIImage imageNamed:imageName]
             forState:UIControlStateNormal];
    [itemBar setImage:[UIImage imageNamed:highlightedImageName]
             forState:UIControlStateHighlighted];
    [itemBar setTag:identitiyTag];
    [itemBar addTarget:self action:@selector(itemBarDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:itemBar];
    [self.toolbarItems addObject:itemBar];
}

- (void)itemBarDidClick:(UIButton *)itemBar {
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didSelectedItemType:)]) {
        [self.delegate composeToolbar:self didSelectedItemType:itemBar.tag];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat itemBarWidth = self.width / self.toolbarItems.count;
    CGFloat itemBarHeight = self.height;
    [self.toolbarItems enumerateObjectsUsingBlock:^(UIView *itemBar, NSUInteger index, BOOL *stop) {
        [itemBar setFrame:CGRectMake(index*itemBarWidth, 0, itemBarWidth, itemBarHeight)];
    }];
}


@end
