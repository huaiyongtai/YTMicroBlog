//
//  HYTStatusPicturesView.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/30.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusPicturesView.h"
#import "HYTStatusPictureView.h"

#define ReviseColsWithCount(count) (count > 2 ? 3 : 2)

@interface HYTStatusPicturesView ()

@property (nonatomic, strong) NSMutableArray *pictureViews;

@end

static const CGFloat kPictureViewPadding = 10;

@implementation HYTStatusPicturesView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        _pictureViews = [NSMutableArray array];
    }
    return self;
}

- (void)setPictures:(NSArray *)pictures {
    
    _pictures = pictures;
    
    //创建足够现实的pictureView
    while (self.pictureViews.count < pictures.count) {
        HYTStatusPictureView *pictureView = [[HYTStatusPictureView alloc] init];
        [self addSubview:pictureView];
        [self.pictureViews addObject:pictureView];
    }
    
    [self.pictureViews enumerateObjectsUsingBlock:^(HYTStatusPictureView *pictureView, NSUInteger index, BOOL *stop) {
        BOOL isShow= index < pictures.count;
        if (isShow) { //用于显示的
            pictureView.picture = pictures[index];
        }
        pictureView.hidden = !isShow;
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSInteger cols = ReviseColsWithCount(self.pictures.count);
    CGFloat pictureViewWH = (self.width - (cols - 1) * kPictureViewPadding) / cols;
    [self.pictureViews enumerateObjectsUsingBlock:^(HYTStatusPictureView *pictureView, NSUInteger index, BOOL *stop) {
        if (index >= self.pictures.count) {
            *stop = YES;
        }
        pictureView.frame = CGRectMake(index%cols * (pictureViewWH + kPictureViewPadding),
                                       index/cols * (pictureViewWH + kPictureViewPadding),
                                       pictureViewWH,
                                       pictureViewWH);
    }];
}

+ (CGSize)statusPicturesViewWithMaxWidth:(CGFloat)maxWidth showCount:(NSInteger)showCount {
    
    NSInteger cols = ReviseColsWithCount(showCount);
    NSInteger rows = (showCount + cols - 1) / cols;
    
    CGFloat pictureViewWH = (maxWidth - (cols-1)*kPictureViewPadding) / cols;   //图片的宽高
    return CGSizeMake(maxWidth, rows * (pictureViewWH + kPictureViewPadding) - kPictureViewPadding);
    
}



@end
