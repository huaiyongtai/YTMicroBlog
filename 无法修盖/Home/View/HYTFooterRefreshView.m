//
//  HYTFooterRefreshView.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/1.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTFooterRefreshView.h"

@implementation HYTFooterRefreshView

+ (instancetype)footerRefreshView {
    
    HYTFooterRefreshView *footRefreshView = [[HYTFooterRefreshView alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
    return footRefreshView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UILabel *tipMsgLabel = [[UILabel alloc] init];
        [tipMsgLabel setText:@"正在加载更多数据.."];
        [tipMsgLabel setFont:[UIFont systemFontOfSize:15]];
        [tipMsgLabel setBackgroundColor:[UIColor clearColor]];
        [tipMsgLabel sizeToFit];
        [self addSubview:tipMsgLabel];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
        [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [self addSubview:activityView];
        
        CGFloat padding = 10;
        [tipMsgLabel setFrame:CGRectMake((SCREEN_WIDTH-tipMsgLabel.width)*0.5 - padding, 0, tipMsgLabel.width, frame.size.height)];
        [activityView setFrame:CGRectMake(tipMsgLabel.rightX + padding, 0, activityView.width, frame.size.height)];
    }
    return self;
}



@end
