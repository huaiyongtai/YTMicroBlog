//
//  HYTEmoticonTabBarItem.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonTabBarItem.h"

@implementation HYTEmoticonTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self setTitleColor:HYTCOLOR(183, 183, 183) forState:UIControlStateNormal];
        [self setTitleColor:HYTCOLOR(99, 99, 99) forState:UIControlStateDisabled];
        [self setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
