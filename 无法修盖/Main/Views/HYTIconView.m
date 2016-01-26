//
//  HYTIconView.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/31.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTIconView.h"
#import "UIImageView+WebCache.h"
#import "HYTUser.h"

@interface HYTIconView ()

@property (nonatomic, weak) UIImageView *verifiedView;
@property (nonatomic, weak) UIImageView *iconImageView;

@end

@implementation HYTIconView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconImageView = [[UIImageView alloc] init]; {
            [iconImageView setContentMode:UIViewContentModeScaleToFill];
            [iconImageView.layer setBorderColor:HYTCOLOR(230, 230, 230).CGColor];
            [iconImageView.layer setBorderWidth:0.5];
            [iconImageView.layer setMasksToBounds:YES];
        }
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
        
        
    }
    return self;
}


- (void)setUser:(HYTUser *)user {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profileImageURL] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    switch (user.verifiedType) {
        case HYTUserVerifiedPersonal: {
            [self.verifiedView setHidden:NO];
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_vip"]];
            break;
        }
        case HYTUserVerifiedEnterprise: {
            [self.verifiedView setHidden:NO];
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
            break;
        }
        case HYTUserVerifiedGrassroot: {
            [self.verifiedView setHidden:NO];
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_grassroot"]];
            break;
        }
        case HYTUserVerifiedGirl: {
            [self.verifiedView setHidden:NO];
            [self.verifiedView setImage:[UIImage imageNamed:@"avatar_vgirl"]];
            break;
        }
        default: {
            [self.verifiedView setHidden:YES];
            break;
        }
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.iconImageView setFrame:self.bounds];
    [self.iconImageView.layer setCornerRadius:self.width * 0.5];
    if (self.verifiedView.image) {
        CGFloat width = self.verifiedView.image.size.width;
        CGFloat height = self.verifiedView.image.size.height;
        [self.verifiedView setFrame:CGRectMake(self.width-width, self.height-height, width, height)];
    }
}


@end
