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
static CGFloat kNormalMargin   = 17;    //普通内容的间距
static CGFloat kSmallMargin    = 10;    //小间距 （用户名-时间、时间-来源）
+ (instancetype)statusFrameWithStatus:(HYTStatus *)status {
    
    HYTStatusFrame *statusFrame = [[self alloc] init];
    statusFrame.status = status;
    return statusFrame;
}

- (void)setStatus:(HYTStatus *)status {
    
    _status = status;
    HYTUser *user = status.user;
    
    CGFloat cellCurrentHeight = 0;
    CGFloat cellWidth = SCREEN_WIDTH;

    /** 用户头像Frame */
    CGFloat profileImageWidth = 50;
    CGFloat profileImageHeight = 50;
    CGFloat profileImageX = kNormalMargin;
    CGFloat profileImageY = kNormalMargin;
    self.profileImageViewF = CGRectMake(profileImageX, profileImageY, profileImageWidth, profileImageHeight);
    
    /** 用户昵称Frame */
    CGFloat nameX = CGRectGetMaxX(self.profileImageViewF) + kNormalMargin;
    CGFloat nameY = profileImageY;
    CGSize nameSize = [user.name yt_sizeWithFont:HYTStatusFrameNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 用户会员图标Frame */
    if (user.isVip) {
        CGFloat mbMarkX = CGRectGetMaxX(self.nameLabelF) + kSmallMargin;
        CGFloat mbMarkY = nameY;
        CGFloat mbMarkHeight = nameSize.height;
        CGFloat mbMarkWidth = 36;
        self.mbMarkViewF = CGRectMake(mbMarkX, mbMarkY, mbMarkWidth, mbMarkHeight);
    }
    
    /** 微博来源Frame */
    CGFloat sourceX = nameX;
    CGFloat sourceY = CGRectGetMaxY(self.nameLabelF) + kSmallMargin;
    CGSize sourceSize = [status.source yt_sizeWithFont:HYTStatusFrameSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 微博创建时间Frame */
    CGFloat createdAtX = CGRectGetMaxX(self.sourceLabelF) + kSmallMargin;
    CGFloat createdAtY = sourceY;
    CGSize createdAtSize = [status.createdAt yt_sizeWithFont:HYTStatusFrameCreatedAtFont];
    self.createdAtLabelF = (CGRect){{createdAtX, createdAtY}, createdAtSize};
    
    /** 微博信息内容Frame */
    CGFloat contentX = profileImageX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.profileImageViewF), CGRectGetMaxY(self.sourceLabelF)) + kNormalMargin;
    CGFloat contentMaxWidth = cellWidth - contentX - kNormalMargin;
    CGSize contentSize = [status.text yt_sizeWithFont:HYTStatusFrameContentFont maxWidth:contentMaxWidth];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};

    CGFloat pictureX = contentX;
    CGFloat pictureY = CGRectGetMaxY(self.contentLabelF);
    CGFloat pictureWidth = 0;
    CGFloat pictureHeight = 0;
    if (status.pictures.count) {
        pictureY += kSmallMargin;
        pictureWidth = 100;
        pictureHeight = pictureWidth;
    }
    self.pictureViewF = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
    
    /** 原创微博Frame */
    self.originalStatusViewF = CGRectMake(0, kSmallMargin, cellWidth, CGRectGetMaxY(self.pictureViewF));
    cellCurrentHeight = CGRectGetMaxY(self.originalStatusViewF);
    
    /***********************转发微博***********************/
    if (status.retweetedStatus) {
        
        HYTStatus *retweetedStatus = status.retweetedStatus;
        CGFloat retweetedContentX = kNormalMargin;
        CGFloat retweetedContentY = kNormalMargin;
        NSString *retweentContentText = [NSString stringWithFormat:@"%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        CGFloat retweetedMaxWidth = cellWidth - retweetedContentX - kNormalMargin;
        CGSize retweetedContentSize = [retweentContentText yt_sizeWithFont:HYTStatusFrameReweetedContentFont maxWidth:retweetedMaxWidth];
        self.retweetedContentLabelF = (CGRect){{retweetedContentX, retweetedContentY}, retweetedContentSize};
        
        CGFloat retweetedPictureX = retweetedContentX;
        CGFloat retweetedPictureY = CGRectGetMaxY(self.retweetedContentLabelF);
        CGFloat retweetedPictureWidth = 0;
        CGFloat retweetedPictureHeight = 0;
        if (retweetedStatus.pictures.count) {
            retweetedPictureY += kSmallMargin;
            retweetedPictureWidth = 100;
            retweetedPictureHeight = retweetedPictureWidth;
        }
        self.retweetedPictureViewF = CGRectMake(retweetedPictureX, retweetedPictureY, retweetedPictureWidth, retweetedPictureHeight);
        
        self.retweetedStatusViewF = CGRectMake(0, cellCurrentHeight, cellWidth, CGRectGetMaxY(self.retweetedPictureViewF)+kNormalMargin);
        
        cellCurrentHeight = CGRectGetMaxY(self.retweetedStatusViewF);
    }
    
    self.toolBarF = CGRectMake(0, cellCurrentHeight, cellWidth, 34);
    
    cellCurrentHeight = CGRectGetMaxY(self.toolBarF);
    self.cellTotalHeight = cellCurrentHeight;
}

@end
