//
//  HYTEmoticonsView.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/18.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSUInteger HYTEmotionPageMaxCols;
extern const NSUInteger HYTEmotionPageMaxRows;
extern const NSUInteger HYTEmotionPageCount;

@interface HYTEmoticonsView : UIScrollView

@property (nonatomic, strong) NSArray *emoticons;

@end
