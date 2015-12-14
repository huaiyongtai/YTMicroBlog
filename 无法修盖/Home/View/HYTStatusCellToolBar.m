//
//  HYTStatusCellToolBar.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/6.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusCellToolBar.h"
#import "HYTStatus.h"

@interface HYTStatusCellToolBar ()

@property (nonatomic, weak) UIButton *repostBtn;

@property (nonatomic, weak) UIButton *commentBtn;

@property (nonatomic, weak) UIButton *attitudeBtn;


@end

@implementation HYTStatusCellToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.repostBtn = [self addSubBtnWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
        self.commentBtn = [self addSubBtnWithTitle:@"评论" imageName:@"timeline_icon_comment"];
        self.attitudeBtn = [self addSubBtnWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
    }
    return self;
}

- (UIButton *)addSubBtnWithTitle:(NSString *)title imageName:(NSString *)imageName {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self addSubview:btn];
    
    return btn;
}

- (void)setStatus:(HYTStatus *)status {
    
    _status = status;
    
    [self setupBarBtn:self.repostBtn useTitleCount:status.repostsCount];
    
    [self setupBarBtn:self.commentBtn useTitleCount:status.commentsCount];
    
    [self setupBarBtn:self.attitudeBtn useTitleCount:status.attitudesCount];
}

- (void)setupBarBtn:(UIButton *)btn useTitleCount:(NSString *)title {
    
    NSUInteger currentCount = title.integerValue;
    NSString *btnTitle = btn.currentTitle;
    
    if (currentCount >= 10000) {
        CGFloat formatNumber = currentCount / 10000.0f;
        btnTitle = [NSString stringWithFormat:@"%0.1f万", formatNumber];
        btnTitle = [btnTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (currentCount) {
        btnTitle = title;
    }
    
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat subBtnWidth =  self.width / self.subviews.count;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView setFrame:CGRectMake(subBtnWidth * idx, 0, subBtnWidth, self.height)];
    }];
}





@end
