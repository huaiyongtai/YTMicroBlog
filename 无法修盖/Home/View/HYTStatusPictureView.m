//
//  HYTStatusPictureView.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/30.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusPictureView.h"
#import "UIImageView+WebCache.h"
#import "HYTStatusPicture.h"

@interface HYTStatusPictureView ()

@property (nonatomic, weak) UIImageView *gifTipView;

@end

@implementation HYTStatusPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *gifTipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifTipView];
        self.gifTipView = gifTipView;
        
        [self setContentMode:UIViewContentModeScaleAspectFill];
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void)setPicture:(HYTStatusPicture *)picture {
    _picture = picture;
    
    UIImage *picturePlaceholder = [UIImage imageNamed:@"timeline_image_placeholder"];
    [self sd_setImageWithURL:[NSURL URLWithString:picture.thumbnailPic]
            placeholderImage:picturePlaceholder];
    
    
    //判断是否显示GIF图片提示
    if ([[picture.thumbnailPic lowercaseString] hasSuffix:@"gif"]) {
        [self.gifTipView setHidden:NO];
    } else {
        [self.gifTipView setHidden:YES];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.gifTipView setFrame:CGRectMake(self.width-self.gifTipView.width,
                                         self.height-self.gifTipView.height,
                                         self.gifTipView.width,
                                         self.gifTipView.height)];
}

@end
