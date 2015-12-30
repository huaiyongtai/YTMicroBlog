//
//  HYTStatusPicturesView.h
//  无法修盖
//
//  Created by HelloWorld on 15/12/30.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTStatusPicturesView : UIView

/** 要显示的图片模型数组 */
@property (nonatomic, strong) NSArray *pictures;

+ (CGSize)statusPicturesViewWithMaxWidth:(CGFloat)maxWidth showCount:(NSInteger)showCount;

@end
