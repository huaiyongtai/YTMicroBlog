//
//  HYTStatusFrame.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#define HYTStatusFrameNameFont [UIFont systemFontOfSize:15]

#import "HYTStatusFrame.h"
#import "HYTStatusPicturesView.h"

@implementation HYTStatusFrame

const CGFloat HYTStatusFrameNormalMargin = 17;  //普通内容的间距
const CGFloat HYTStatusFrameSmallMargin  = 10;  //小间距 （用户名-时间、时间-来源）

//static CGFloat kVerticalMargin = 25;    //距离边框的竖直距离(暂时弃用)
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
    CGFloat profileImageX = HYTStatusFrameNormalMargin;
    CGFloat profileImageY = HYTStatusFrameNormalMargin;
    self.profileImageViewF = CGRectMake(profileImageX, profileImageY, profileImageWidth, profileImageHeight);
    
    /** 用户昵称Frame */
    CGFloat nameX = CGRectGetMaxX(self.profileImageViewF) + HYTStatusFrameNormalMargin;
    CGFloat nameY = profileImageY;
    CGSize nameSize = [user.name yt_sizeWithFont:HYTStatusFrameNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 用户会员图标Frame */
    if (user.isVip) {
        CGFloat mbMarkX = CGRectGetMaxX(self.nameLabelF) + HYTStatusFrameSmallMargin;
        CGFloat mbMarkY = nameY;
        CGFloat mbMarkHeight = nameSize.height;
        CGFloat mbMarkWidth = 36;
        self.mbMarkViewF = CGRectMake(mbMarkX, mbMarkY, mbMarkWidth, mbMarkHeight);
    }
    
    /** 微博创建时间Frame */
    CGFloat createdAtX = nameX;
    CGFloat createdAtY = CGRectGetMaxY(self.nameLabelF) + HYTStatusFrameSmallMargin;
    CGSize createdAtSize = [status.createdAt yt_sizeWithFont:HYTStatusFrameCreatedAtFont];
    self.createdAtLabelF = (CGRect){{createdAtX, createdAtY}, createdAtSize};
    
    /** 微博来源Frame */
    CGFloat sourceX = CGRectGetMaxX(self.createdAtLabelF) + HYTStatusFrameSmallMargin;
    CGFloat sourceY = createdAtY;
    CGSize sourceSize = [status.source yt_sizeWithFont:HYTStatusFrameSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 微博信息内容Frame */
    CGFloat contentX = profileImageX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.profileImageViewF), CGRectGetMaxY(self.sourceLabelF)) + HYTStatusFrameNormalMargin;
    CGFloat contentMaxWidth = cellWidth - contentX - HYTStatusFrameNormalMargin;
    CGSize contentSize = [status.text yt_sizeWithFont:HYTStatusFrameContentFont maxWidth:contentMaxWidth];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};

    CGFloat picturesViewX = contentX;
    CGFloat picturesViewY = CGRectGetMaxY(self.contentLabelF);
    CGFloat picturesViewMaxWidth = contentMaxWidth;
    CGSize  picturesViewSize = CGSizeZero;
    if (status.pictures.count) {
        picturesViewY += HYTStatusFrameSmallMargin;
        picturesViewSize = [HYTStatusPicturesView statusPicturesViewWithMaxWidth:picturesViewMaxWidth showCount:status.pictures.count];
    }
    self.picturesViewF = (CGRect){{picturesViewX, picturesViewY}, picturesViewSize};
    
    /** 原创微博Frame */
    self.originalStatusViewF = CGRectMake(0, HYTStatusFrameSmallMargin, cellWidth, CGRectGetMaxY(self.picturesViewF));
    cellCurrentHeight = CGRectGetMaxY(self.originalStatusViewF);
    
    /***********************转发微博***********************/
    if (status.retweetedStatus) {
        
        HYTStatus *retweetedStatus = status.retweetedStatus;
        CGFloat retweetedContentX = HYTStatusFrameNormalMargin;
        CGFloat retweetedContentY = HYTStatusFrameNormalMargin;
        NSString *retweentContentText = [NSString stringWithFormat:@"%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        CGFloat retweetedMaxWidth = cellWidth - retweetedContentX - HYTStatusFrameNormalMargin;
        CGSize retweetedContentSize = [retweentContentText yt_sizeWithFont:HYTStatusFrameReweetedContentFont maxWidth:retweetedMaxWidth];
        self.retweetedContentLabelF = (CGRect){{retweetedContentX, retweetedContentY}, retweetedContentSize};
        
        CGFloat retweetedPicturesViewX = retweetedContentX;
        CGFloat retweetedPicturesViewY = CGRectGetMaxY(self.retweetedContentLabelF);
        CGFloat retweetedPicturesViewMaxWidth = retweetedMaxWidth;
        CGSize  retweetedPicturesViewSize = CGSizeZero;
        if (retweetedStatus.pictures.count) {
            retweetedPicturesViewY += HYTStatusFrameSmallMargin;
            retweetedPicturesViewSize = [HYTStatusPicturesView statusPicturesViewWithMaxWidth:retweetedPicturesViewMaxWidth showCount:retweetedStatus.pictures.count];
        }
        self.retweetedPicturesViewF = (CGRect){{retweetedPicturesViewX, retweetedPicturesViewY}, retweetedPicturesViewSize};
        
        self.retweetedStatusViewF = CGRectMake(0, cellCurrentHeight, cellWidth, CGRectGetMaxY(self.retweetedPicturesViewF)+HYTStatusFrameNormalMargin);
        
        cellCurrentHeight = CGRectGetMaxY(self.retweetedStatusViewF);
    }
    
    self.toolBarF = CGRectMake(0, cellCurrentHeight, cellWidth, 34);
    
    cellCurrentHeight = CGRectGetMaxY(self.toolBarF);
    self.cellTotalHeight = cellCurrentHeight;
}

@end
