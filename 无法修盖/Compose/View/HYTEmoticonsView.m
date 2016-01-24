//
//  HYTEmoticonsView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/18.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonsView.h"
#import "HYTEmoticonBtn.h"

const NSUInteger HYTEmotionPageMaxCols = 7;
const NSUInteger HYTEmotionPageMaxRows = 3;
const NSUInteger HYTEmotionPageCount = HYTEmotionPageMaxCols * HYTEmotionPageMaxRows -1;

@interface HYTEmoticonsView ()

@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, strong) NSMutableArray *deleteBtns;

@end

@implementation HYTEmoticonsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
    }
    
    return self;
}


- (void)setEmoticons:(NSArray *)emoticons {
    
    _emoticons = emoticons;
    
    _emotionViews = [NSMutableArray array];
    [emoticons enumerateObjectsUsingBlock:^(HYTEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        HYTEmoticonBtn *emoticonView = [HYTEmoticonBtn emoticonBtn];
        [emoticonView addTarget:self action:@selector(emoticonViewDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        emoticonView.emoticon = emoticon;
        [self addSubview:emoticonView];
        [self.emotionViews addObject:emoticonView];
    }];
    
    _deleteBtns = [NSMutableArray array];
    NSInteger pageCount = (emoticons.count + HYTEmotionPageCount -1) / HYTEmotionPageCount;
    for (int index = 0; index<pageCount; index++) {
        UIButton *deleteBtn = ({
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [deleteBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
            [deleteBtn addTarget:self action:@selector(deleteDidSelected) forControlEvents:UIControlEventTouchUpInside];
            deleteBtn;
        });
        [self addSubview:deleteBtn];
        [self.deleteBtns addObject:deleteBtn];
    }
}

- (void)deleteDidSelected {
    NSLog(@"deleteDidClick");
}

- (void)emoticonViewDidSelected:(UIButton *)emoticonView {
    NSLog(@"emoticonViewDidSelected");
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    CGFloat marginVertical = 12;    //竖直间距
    CGFloat marginHorizontal = 10;  //水平间距
    CGFloat emoticonViewWidth = (self.width - marginHorizontal * 2) / HYTEmotionPageMaxCols;
    CGFloat emoticonViewHeight = (self.height - marginVertical) / HYTEmotionPageMaxRows ;
    [self.emotionViews enumerateObjectsUsingBlock:^(UIView *emoticonView, NSUInteger idx, BOOL *stop) {
        [emoticonView setFrame:({
            NSUInteger idxXY = idx % HYTEmotionPageCount; //校正计算所用到的索引值
            CGRectMake(marginHorizontal + emoticonViewWidth * (idxXY % HYTEmotionPageMaxCols) + self.width * (idx/HYTEmotionPageCount),
                       marginVertical + emoticonViewHeight * (idxXY / HYTEmotionPageMaxCols % HYTEmotionPageMaxRows),
//                     ==emoticonViewHeight * (idxXY / maxCols) - self.height * (idx/HYTEmotionPageCount),
                       emoticonViewWidth,
                       emoticonViewHeight);
        
        })];
    }];
    
    [self.deleteBtns enumerateObjectsUsingBlock:^(UIButton *deleteBtn, NSUInteger idx, BOOL *stop) {
        [deleteBtn setFrame:CGRectMake(self.width - marginHorizontal - emoticonViewWidth + self.width * idx,
                                       self.height - emoticonViewHeight,
                                       emoticonViewWidth,
                                       emoticonViewHeight)];
    }];
}

@end
