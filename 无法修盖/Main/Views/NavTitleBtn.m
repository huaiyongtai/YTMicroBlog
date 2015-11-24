//
//  NavTitleBtn.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/30.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "NavTitleBtn.h"

static CGFloat const kTitleAndImagePadding = 10;

@implementation NavTitleBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    [super imageRectForContentRect:contentRect];
    
    //计算文字的长度
    CGSize titleSize = [self.currentTitle boundingRectWithSize:CGSizeMake(contentRect.size.width, contentRect.size.height)
                                                       options:NSStringDrawingTruncatesLastVisibleLine
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}
                                                       context:nil].size;
    
    //计算内容的总的宽度
    CGFloat totalWidth = self.currentImage.size.width + titleSize.width + kTitleAndImagePadding;
    
    CGFloat imageViewHeight = self.currentImage.size.height;
    CGFloat imageViewWidth  = self.currentImage.size.width;
    
    CGFloat imageViewX = (contentRect.size.width - totalWidth) * 0.5 + titleSize.width + kTitleAndImagePadding + self.imageEdgeInsets.right - self.imageEdgeInsets.left;
    
    CGFloat imageViewY = (contentRect.size.height - imageViewHeight) * 0.5 + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
    
    return CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    [super titleRectForContentRect:contentRect];
    
//    UIEdgeInsets 在原有的基础之上进行偏移
    
    //计算文字的长度
    CGSize titleSize = [self.currentTitle boundingRectWithSize:CGSizeMake(contentRect.size.width, contentRect.size.height)
                                                       options:NSStringDrawingTruncatesLastVisibleLine
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}
                                                       context:nil].size;
    
    //计算内容的总的宽度
    CGFloat totalWidth = self.currentImage.size.width + titleSize.width + kTitleAndImagePadding;

    CGFloat titleLabelX = (contentRect.size.width - totalWidth) * 0.5 + self.titleEdgeInsets.right - self.titleEdgeInsets.left;
    CGFloat titleLabelY = (contentRect.size.height - titleSize.height) * 0.5 + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
    
    return CGRectMake(titleLabelX, titleLabelY, titleSize.width, titleSize.height);
}


@end
