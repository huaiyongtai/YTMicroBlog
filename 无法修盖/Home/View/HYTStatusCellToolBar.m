//
//  HYTStatusCellToolBar.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/6.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusCellToolBar.h"

@implementation HYTStatusCellToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubBtnWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
        [self addSubBtnWithTitle:@"评论" imageName:@"timeline_icon_comment"];
        [self addSubBtnWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
    }
    return self;
}

- (void)addSubBtnWithTitle:(NSString *)title imageName:(NSString *)imageName {
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [commentBtn setTitle:title forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self addSubview:commentBtn];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat subBtnWidth =  self.width / self.subviews.count;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView setFrame:CGRectMake(subBtnWidth * idx, 0, subBtnWidth, self.height)];
    }];
}





@end
