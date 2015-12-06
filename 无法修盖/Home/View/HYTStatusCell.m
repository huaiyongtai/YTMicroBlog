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

@interface HYTStatusCell ()

/** 原创微博 */
@property (nonatomic, weak) UIView *originalStatusView;

/** 用户头像 */
@property (nonatomic, weak) UIImageView *profileImageView;

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
@property (nonatomic, weak) UIImageView *pictureView;

/** 转发微博 */
@property (nonatomic, weak) UIView *retweetedStatusView;

/** 转发微博内容 */
@property (nonatomic, weak) UILabel *retweetedContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) UIImageView *retweetedPictureView;

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
    UIImageView *profileImageView = [[UIImageView alloc] init];
    [profileImageView setContentMode:UIViewContentModeScaleAspectFill];
    [profileImageView.layer setMasksToBounds:YES];
    [originalStatusView addSubview:profileImageView];
    self.profileImageView = profileImageView;
    
    /** 用户昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setFont:HYTStatusFrameNameFont];
    [originalStatusView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 用户会员图标 */
    UIImageView *mbMarkView = [[UIImageView alloc] init];
    [mbMarkView setContentMode:UIViewContentModeScaleAspectFit];
    [originalStatusView addSubview:mbMarkView];
    self.mbMarkView = mbMarkView;
    
    /** 微博来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [sourceLabel setFont:HYTStatusFrameSourceFont];
    [originalStatusView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 微博创建时间 */
    UILabel *createdAtLabel = [[UILabel alloc] init];
    [createdAtLabel setFont:HYTStatusFrameCreatedAtFont];
    [originalStatusView addSubview:createdAtLabel];
    self.createdAtLabel = createdAtLabel;

    /** 微博信息内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:HYTStatusFrameContentFont];
    [originalStatusView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /** 配图 */
    UIImageView *pictureView = [[UIImageView alloc] init];
    [pictureView setBackgroundColor:[UIColor blackColor]];
    [pictureView setContentMode:UIViewContentModeScaleAspectFill];
    [pictureView.layer setMasksToBounds:YES];
    [originalStatusView addSubview:pictureView];
    self.pictureView = pictureView;
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
    UIImageView *retweetedPictureView = [[UIImageView alloc] init];
    [retweetedPictureView setContentMode:UIViewContentModeScaleToFill];
    [retweetedPictureView.layer setMasksToBounds:YES];
    [retweetedStatusView addSubview:retweetedPictureView];
    self.retweetedPictureView = retweetedPictureView;
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
    
    UIImage *profilePlaceholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:user.profileImageURL] placeholderImage:profilePlaceholderImage];
    [self.profileImageView setFrame:statusFrame.profileImageViewF];
    
    [self.nameLabel setText:user.name];
    [self.nameLabel setFrame:statusFrame.nameLabelF];
    
    if (user.isVip) {
        NSString *mbMarkNum = [NSString stringWithFormat:@"userinfo_membership_level%i", user.mbRank];
        [self.mbMarkView setImage:[UIImage imageNamed:mbMarkNum]];
        [self.mbMarkView setFrame:statusFrame.mbMarkViewF];
    }

    [self.sourceLabel setText:status.source];
    [self.sourceLabel setFrame:statusFrame.sourceLabelF];
    
    [self.createdAtLabel setText:status.createdAt];
    [self.createdAtLabel setFrame:statusFrame.createdAtLabelF];
    
    [self.contentLabel setText:status.text];
    [self.contentLabel setFrame:statusFrame.contentLabelF];
    
    if (status.pictures.count) {
        HYTPicture *picture = status.pictures[0];
        UIImage *picturePlaceholder = [UIImage imageNamed:@"timeline_image_placeholder"];
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:picture.thumbnailPic] placeholderImage:picturePlaceholder];
        [self.pictureView setFrame:statusFrame.pictureViewF];
    }
    
    if (status.retweetedStatus) {
        
        HYTStatus *retweetedStatus = status.retweetedStatus;
        
        [self.retweetedStatusView setFrame:statusFrame.retweetedStatusViewF];
        
        NSString *retweetedText = [NSString stringWithFormat:@"%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        [self.retweetedContentLabel setText:retweetedText];
        [self.retweetedContentLabel setFrame:statusFrame.retweetedContentLabelF];
        
        if (retweetedStatus.pictures.count) {
            HYTPicture *picture = retweetedStatus.pictures[0];
            UIImage *picturePlaceholder = [UIImage imageNamed:@"timeline_image_placeholder"];
            [self.retweetedPictureView sd_setImageWithURL:[NSURL URLWithString:picture.thumbnailPic] placeholderImage:picturePlaceholder];
            [self.retweetedPictureView setFrame:statusFrame.retweetedPictureViewF];
        }
    }
    
    [self.toolBar setFrame:statusFrame.toolBarF];
}

#pragma mark - 清除复用数据
- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    [self.mbMarkView setImage:nil];
    [self.mbMarkView setFrame:CGRectZero];
    
    [self.pictureView setImage:nil];
    [self.pictureView setFrame:CGRectZero];
    
    [self.retweetedStatusView setFrame:CGRectZero];
    
    [self.retweetedContentLabel setText:nil];
    [self.retweetedContentLabel setFrame:CGRectZero];
    
    [self.retweetedPictureView setImage:nil];
    [self.retweetedPictureView setFrame:CGRectZero];
    
}
@end
