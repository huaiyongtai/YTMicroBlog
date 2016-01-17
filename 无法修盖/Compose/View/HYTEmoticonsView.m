//
//  HYTEmoticonsView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/18.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonsView.h"
#import "HYTComposeEmoticon.h"

@interface HYTEmoticonsView ()

@property (nonatomic, strong) NSMutableArray *emotionViews;

@end

@implementation HYTEmoticonsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self setBackgroundColor:HYTCOLORANDOM];
        
        self.emotionViews = [NSMutableArray array];
    }
    
    return self;
}


- (void)setEmoticons:(NSArray *)emoticons {
    
    
    _emoticons = emoticons;
    
    [emoticons enumerateObjectsUsingBlock:^(HYTComposeEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        UIButton *emoticonView = [UIButton buttonWithType:UIButtonTypeCustom];
        [emoticonView setBackgroundColor:HYTCOLORANDOM];
        [emoticonView setImage:[UIImage imageNamed:emoticon.png] forState:UIControlStateNormal];
        [self addSubview:emoticonView];
        [self.emotionViews addObject:emoticonView];
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSUInteger maxCols = 7;
    NSUInteger maxRows = 3;
    CGFloat emoticonViewWidth = self.width / maxCols;
    CGFloat emoticonViewHeight = self.height / maxRows;
    [self.emotionViews enumerateObjectsUsingBlock:^(UIView *emoticonView, NSUInteger idx, BOOL *stop) {
        [emoticonView setFrame:CGRectMake(emoticonViewWidth * (idx % maxCols + idx / (maxRows)),
//                                          emoticonViewWidth * (idx % maxCols) + self.width * (idx/(maxCols * maxRows)),
                                          emoticonViewHeight * (idx / maxCols % maxRows),
//                                          emoticonViewHeight * (idx / maxCols) - self.height * (idx/(maxCols * maxRows)),
                                          emoticonViewWidth,
                                          emoticonViewHeight)];
        
        
        
    }];
}



@end
