//
//  HYTStatusCell.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusCell.h"
#import "HYTStatusFrame.h"
#import "HYTStatusCellToolBar.h"
#import "UIImageView+WebCache.h"
#import "HYTStatusPicturesView.h"
#import "HYTIconView.h"

@interface HYTStatusCell ()

/** 原创微博 */
@property (nonatomic, weak) UIView *originalStatusView;
/** 用户头像 */
@property (nonatomic, weak) HYTIconView *iconView;
/** 用户昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 用户会员图标 */
@property (nonatomic, weak) UIImageView *mbMarkView;
/** 微博来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 微博创建时间 */
@property (nonatomic, weak) UILabel *createdAtLabel;
/** 微博信息内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 配图 */
@property (nonatomic, weak) HYTStatusPicturesView *picturesView;

/** 转发微博 */
@property (nonatomic, weak) UIView *retweetedStatusView;
/** 转发微博内容 */
@property (nonatomic, weak) UILabel *retweetedContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) HYTStatusPicturesView *retweetedPicturesView;

/** 底部toolBar */
@property (nonatomic, weak) HYTStatusCellToolBar *toolBar;

@end

@implementation HYTStatusCell

+ (instancetype)statusCellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"HYTStatusCell";
    HYTStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (statusCell == nil) {
        statusCell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return statusCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupOriginalStatusView];
        
        [self setupRetweetedStatusView];
        
        [self setupStatusToolBar];
    }
    return self;
}

#pragma mark - 初始化原创微博
- (void)setupOriginalStatusView {
    /** 原创微博 */
    UIView *originalStatusView = [[UIView alloc] init];
    [originalStatusView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:originalStatusView];
    self.originalStatusView = originalStatusView;
    
    /** 用户头像 */
    HYTIconView *iconView = [[HYTIconView alloc] init];
    [originalStatusView addSubview:iconView];
    self.iconView = iconView;
    
    /** 用户昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setFont:HYTStatusFrameNameFont];
    [nameLabel setTextColor:HYTCOLOR(241, 75, 0)];
    [originalStatusView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 用户会员图标 */
    UIImageView *mbMarkView = [[UIImageView alloc] init];
    [mbMarkView setContentMode:UIViewContentModeScaleAspectFit];
    [originalStatusView addSubview:mbMarkView];
    self.mbMarkView = mbMarkView;
    
    /** 微博创建时间 */
    UILabel *createdAtLabel = [[UILabel alloc] init];
    [createdAtLabel setFont:HYTStatusFrameCreatedAtFont];
    [createdAtLabel setTextColor:HYTCOLOR(255, 109, 0)];
    [originalStatusView addSubview:createdAtLabel];
    self.createdAtLabel = createdAtLabel;
    
    /** 微博来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [sourceLabel setFont:HYTStatusFrameSourceFont];
    [sourceLabel setTextColor:HYTCOLOR(131, 131, 131)];
    [originalStatusView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;

    /** 微博信息内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:HYTStatusFrameContentFont];
    [originalStatusView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /** 配图 */
    HYTStatusPicturesView *picturesView = [[HYTStatusPicturesView alloc] init];
    [originalStatusView addSubview:picturesView];
    self.picturesView = picturesView;
}
#pragma mark - 初始化转发微博
- (void)setupRetweetedStatusView {
    
    /** 转发微博 */
    UIView *retweetedStatusView = [[UIView alloc] init];
    [retweetedStatusView setBackgroundColor:HYTCOLOR(245, 245, 245)];
    [self.contentView addSubview:retweetedStatusView];
    self.retweetedStatusView = retweetedStatusView;
    
    /** 转发微博内容(姓名+内容) */
    UILabel *retweetedContentLabel = [[UILabel alloc] init];
    [retweetedContentLabel setNumberOfLines:0];
    [retweetedContentLabel setFont:HYTStatusFrameReweetedContentFont];
    [retweetedStatusView addSubview:retweetedContentLabel];
    self.retweetedContentLabel = retweetedContentLabel;
    
    /** 转发微博配图 */
    HYTStatusPicturesView *retweetedPicturesView = [[HYTStatusPicturesView alloc] init];
    [retweetedStatusView addSubview:retweetedPicturesView];
    self.retweetedPicturesView = retweetedPicturesView;
}

#pragma mark - 添加底部toolBar
- (void)setupStatusToolBar {
    HYTStatusCellToolBar *toolBar = [[HYTStatusCellToolBar alloc] init];
    [toolBar setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark - 设置Cell上的数据
- (void)setStatusFrame:(HYTStatusFrame *)statusFrame {
    
    _statusFrame = statusFrame;
    HYTStatus *status = statusFrame.status;
    HYTUser *user = status.user;

    [self.originalStatusView setFrame:statusFrame.originalStatusViewF];
    
    [self.iconView setUser:user];
    [self.iconView setFrame:statusFrame.iconViewF];
    
    [self.nameLabel setText:user.name];
    [self.nameLabel setFrame:statusFrame.nameLabelF];
    
    if (user.isVip) {
        NSString *mbMarkNum = [NSString stringWithFormat:@"common_icon_membership_level%i", user.mbRank];
        [self.mbMarkView setImage:[UIImage imageNamed:mbMarkNum]];
        [self.mbMarkView setFrame:statusFrame.mbMarkViewF];
        [self.mbMarkView setHidden:NO];
    } else {
        [self.mbMarkView setHidden:YES];
    }

    /** 微博创建时间Frame */
    NSString *currentCreatAt = status.createdAt;
    BOOL isRecalculateCreatFrame = status.createdAt.length != self.createdAtLabel.text.length; //在cell的循环利用中判断是否需要重新计算创建时间的frame
    if (isRecalculateCreatFrame) {
        CGFloat createdAtX = statusFrame.nameLabelF.origin.x;
        CGFloat createdAtY = CGRectGetMaxY(statusFrame.nameLabelF) + HYTStatusFrameSmallMargin;
        CGSize createdAtSize = [status.createdAt yt_sizeWithFont:HYTStatusFrameCreatedAtFont];
        [self.createdAtLabel setFrame:(CGRect){{createdAtX, createdAtY}, createdAtSize}];
    }
    [self.createdAtLabel setText:currentCreatAt];
    
    /** 微博来源Frame */
    BOOL isRecalculateSourceFrame = status.source.length != self.sourceLabel.text.length; //在cell的循环利用中判断是否需要重新计算来源时间的frame
    if (isRecalculateSourceFrame || isRecalculateCreatFrame) {
        CGFloat sourceX = CGRectGetMaxX(self.createdAtLabel.frame) + HYTStatusFrameSmallMargin;
        CGFloat sourceY = self.createdAtLabel.frame.origin.y;
        CGSize sourceSize = [status.source yt_sizeWithFont:HYTStatusFrameSourceFont];
        [self.sourceLabel setFrame:(CGRect){{sourceX, sourceY}, sourceSize}];
    }
    [self.sourceLabel setText:status.source];

    [self.contentLabel setText:status.text];
    [self.contentLabel setFrame:statusFrame.contentLabelF];
    
    if (status.pictures.count) {
        [self.picturesView setPictures:status.pictures];
        [self.picturesView setFrame:statusFrame.picturesViewF];
        [self.picturesView setHidden:NO];
    } else {
        [self.picturesView setHidden:YES];
    }
    
    if (status.retweetedStatus) {
        
        HYTStatus *retweetedStatus = status.retweetedStatus;
        
        [self.retweetedStatusView setFrame:statusFrame.retweetedStatusViewF];
        
        NSString *retweetedText = [NSString stringWithFormat:@"%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        [self.retweetedContentLabel setText:retweetedText];
        [self.retweetedContentLabel setFrame:statusFrame.retweetedContentLabelF];
        
        if (retweetedStatus.pictures.count) {
            [self.retweetedPicturesView setPictures:retweetedStatus.pictures];
            [self.retweetedPicturesView setFrame:statusFrame.retweetedPicturesViewF];
            self.retweetedPicturesView.hidden = NO;
        } else {
            self.retweetedPicturesView.hidden = YES;
        }
        
        [self.retweetedStatusView setHidden:NO];
    } else {
        [self.retweetedStatusView setHidden:YES];
    }
    
    self.toolBar.status = status;
    [self.toolBar setFrame:statusFrame.toolBarF];
}

#pragma mark - 清除复用数据 (不可靠，因为设置frame为CGRectZero时，内部的子控件任然可能显示出来)
//- (void)prepareForReuse {
//    
//    [super prepareForReuse];
//    
//    [self.mbMarkView setImage:nil];
//    [self.mbMarkView setFrame:CGRectZero];
//    [self.retweetedStatusView setFrame:CGRectZero];
//    
//    [self.retweetedContentLabel setText:nil];
//    [self.retweetedContentLabel setFrame:CGRectZero];
//    
//}
@end
