//
//  HYTStatusCell.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusCell.h"
#import "HYTStatusFrame.h"
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

/** 配图 */
@property (nonatomic, weak) UIImageView *pictureView;

/** 微博信息内容 */
@property (nonatomic, weak) UILabel *contentLabel;


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
        /** 原创微博 */
        UIView *originalStatusView = [[UIView alloc] init];
        [self.contentView addSubview:originalStatusView];
        self.originalStatusView = originalStatusView;
        
        /** 用户头像 */
        UIImageView *profileImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:profileImageView];
        self.profileImageView = profileImageView;
        
        /** 用户昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        [nameLabel setFont:HYTStatusFrameNameFont];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 用户会员图标 */
        UIImageView *mbMarkView = [[UIImageView alloc] init];
        [self.contentView addSubview:mbMarkView];
        self.mbMarkView = mbMarkView;
        
        /** 微博来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 微博创建时间 */
        UILabel *createdAtLabel = [[UILabel alloc] init];
        [self.contentView addSubview:createdAtLabel];
        self.createdAtLabel = createdAtLabel;
        
        /** 配图 */
        UIImageView *pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
    
        /** 微博信息内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}

- (void)setStatueFrame:(HYTStatusFrame *)statueFrame {
    
    _statueFrame = statueFrame;
    HYTStatus *status = statueFrame.status;
    HYTUser *user = status.user;

    [self.originalStatusView setFrame:statueFrame.originalStatusViewF];
    
    UIImage *profilePlaceholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:user.profileImageURL] placeholderImage:profilePlaceholderImage];
    [self.profileImageView setFrame:statueFrame.profileImageViewF];
    
    [self.nameLabel setText:user.name];
    [self.nameLabel setFrame:statueFrame.nameLabelF];
    
    [self.mbMarkView setImage:[UIImage imageNamed:@"avatar_default_small"]];
    [self.mbMarkView setFrame:statueFrame.mbMarkViewF];
    
    [self.sourceLabel setText:status.source];
    [self.sourceLabel setFrame:statueFrame.sourceLabelF];
    
    [self.createdAtLabel setText:status.createdAt];
    [self.createdAtLabel setFrame:statueFrame.createdAtLabelF];
    
    [self.contentLabel setText:status.text];
    [self.contentLabel setFrame:statueFrame.contentLabelF];
    
}


@end
