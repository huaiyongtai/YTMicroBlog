//
//  HYTStatusFrame.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#define HYTStatusFrameNameFont [UIFont systemFontOfSize:15]

#import "HYTStatusFrame.h"

@implementation HYTStatusFrame

//static CGFloat kVerticalMargin = 25;    //距离边框的竖直距离(暂时弃用)
static CGFloat kNormalMargin   = 20;    //普通内容的间距
static CGFloat kSmallMargin    = 18;    //小间距 （用户名-时间、时间-来源）
+ (instancetype)statusFrameWithStatus:(HYTStatus *)status {
    
    HYTStatusFrame *statusFrame = [[self alloc] init];
    statusFrame.status = status;
    return statusFrame;
}



- (void)setStatus:(HYTStatus *)status {
    
    _status = status;
    HYTUser *user = status.user;
    
    /** 原创微博Frame */
    CGRect originalStatusViewF;
    
    /** 用户头像Frame */
    CGFloat profileImageWidth = 50;
    CGFloat profileImageHeight = 50;
    CGFloat profileImageX = kNormalMargin;
    CGFloat profileImageY = kNormalMargin;
    self.profileImageViewF = CGRectMake(profileImageX, profileImageY, profileImageWidth, profileImageHeight);
    
    /** 用户昵称Frame */
    ;
    CGFloat nameX = CGRectGetMaxX(self.profileImageViewF) + kNormalMargin;
    CGFloat nameY = profileImageY;
    CGSize nameSize = [user.name yt_sizeWithFont:HYTStatusFrameNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 用户会员图标Frame */
    CGRect mbMarkViewF;
    
    /** 微博来源Frame */
    CGRect sourceLabelF;
    
    /** 微博创建时间Frame */
    CGRect createdAtLabelF;
    
    /** 微博信息内容Frame */
    CGRect contentLabelF;
    
    /** cell的总高度 */
    CGFloat cellTotalHeight;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
