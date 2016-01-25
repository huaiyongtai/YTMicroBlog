//
//  HYTEmoticonsView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/18.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonsView.h"
#import "HYTEmoticonBtn.h"
#import "HYTEmoticonPopView.h"

const NSUInteger HYTEmotionPageMaxCols = 7;
const NSUInteger HYTEmotionPageMaxRows = 3;
const NSUInteger HYTEmotionPageCount = HYTEmotionPageMaxCols * HYTEmotionPageMaxRows -1;

@interface HYTEmoticonsView ()

@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, strong) NSMutableArray *deleteBtns;

@property (nonatomic, strong) HYTEmoticonPopView *popView;

@end

@implementation HYTEmoticonsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressEmoticonRecognizer:)]];
    
    return self;
}


- (HYTEmoticonPopView *)popView {
    
    if (!_popView) {
        _popView = [HYTEmoticonPopView emoticonPopView];
    }
    return _popView;
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

- (void)emoticonViewDidSelected:(HYTEmoticonBtn *)emoticonView {
    NSLog(@"emoticonViewDidSelected");
    
    [self.popView showEmoticon:emoticonView.emoticon fromView:emoticonView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismissViewFromSuper];
    });
}

- (void)pressEmoticonRecognizer:(UIGestureRecognizer *)recognizer {

    CGPoint touchPoint = [recognizer locationInView:self];
    switch (recognizer.state) {
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            HYTEmoticonBtn *emotionView = [self findToPressEmoticonViewFromPoint:touchPoint];
            if (emotionView) {
                [self.popView showEmoticon:emotionView.emoticon fromView:emotionView];
            } else {
                [self.popView dismissViewFromSuper];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            HYTEmoticonBtn *emotionView = [self findToPressEmoticonViewFromPoint:touchPoint];
            if (emotionView) {
                [self emoticonViewDidSelected:emotionView];
            } else {
                [self.popView dismissViewFromSuper];
            }
            break;
        }
    }
}

- (HYTEmoticonBtn *)findToPressEmoticonViewFromPoint:(CGPoint)point {

    if (!CGRectContainsPoint(CGRectMake(self.x, self.y, self.contentSize.width, self.height), point)) {
        [self.popView dismissViewFromSuper];
        return nil;
    }
    __block HYTEmoticonBtn *findView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(HYTEmoticonBtn *emoticonView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emoticonView.frame, point)) {
            findView = emoticonView;
            *stop = YES;
        }
    }];
    return findView;
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
