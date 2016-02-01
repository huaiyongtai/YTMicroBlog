//
//  HYTEmoticonCell.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/8.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonCell.h"
#import "HYTEmoticonBtn.h"
#import "HYTEmoticonsView.h"
#import "HYTEmoticon.h"
#import "HYTEmoticonPopView.h"
#import "HYTRecentEmoticonTool.h"

@interface HYTEmoticonCell ()

@property (nonatomic, strong) NSMutableArray *emoticonViews;

@property (nonatomic, strong) HYTEmoticonPopView *popView;

@property (nonatomic, weak) UIButton *deleteBtn;

@end

@implementation HYTEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(!self) return  nil;
    
    _emoticonViews = [NSMutableArray array];
    
    for (int index = 0; index < HYTEmotionPageCount; index++) {
        HYTEmoticonBtn *emoticonView = [HYTEmoticonBtn emoticonBtn];
        [emoticonView addTarget:self action:@selector(emoticonViewDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emoticonView];
        [self.emoticonViews addObject:emoticonView];
    }
    
    UIButton *deleteBtn = ({
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteDidSelected) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn;
    });
    [self addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
    _popView = [HYTEmoticonPopView emoticonPopView];
    [self addGestureRecognizer:({
        UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressEmoticonRecognizer:)];
        longRecognizer.minimumPressDuration = 0.25;
        longRecognizer;
    })];
    
    return self;

}

- (void)setEmoticons:(NSArray *)emoticons {
    
    _emoticons = emoticons;
    
    [self.emoticonViews enumerateObjectsUsingBlock:^(HYTEmoticonBtn *emoticonView, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isShow= idx < emoticons.count;
        if (isShow) { //用于显示的
            emoticonView.emoticon = emoticons[idx];
        }
        emoticonView.hidden = !isShow;
    }];
}

- (void)deleteDidSelected {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HYTEmoticonDeleteDidSelectedNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)emoticonViewDidSelected:(HYTEmoticonBtn *)emoticonView {
    
    //发送表情选中通知
    NSDictionary *userInfo = @{HYTEmoticonDidSelectedKey : emoticonView.emoticon};
    [[NSNotificationCenter defaultCenter] postNotificationName:HYTEmoticonDidSelectedNotification
                                                        object:nil
                                                      userInfo:userInfo];
    
    [HYTRecentEmoticonTool addEmoticonToRecentEmotions:emoticonView.emoticon];
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
                [self.popView removeFromSuperview];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            HYTEmoticonBtn *emoticonView = [self findToPressEmoticonViewFromPoint:touchPoint];
            if (emoticonView) {
                [self.popView showEmoticon:emoticonView.emoticon fromView:emoticonView delay:0.35 completion:^{
                    [self.popView removeFromSuperview];
                    [self emoticonViewDidSelected:emoticonView];
                }];
            } else {
                [self.popView removeFromSuperview];
            }
            break;
        }
    }
}

/**  根据点击坐标点来查找点击的表情视图 */
- (HYTEmoticonBtn *)findToPressEmoticonViewFromPoint:(CGPoint)point {
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        [self.popView removeFromSuperview];
        return nil;
    }
    __block HYTEmoticonBtn *findView = nil;
    [self.emoticonViews enumerateObjectsUsingBlock:^(HYTEmoticonBtn *emoticonView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emoticonView.frame, point)) {
            if (emoticonView.hidden) {
                findView = nil;
            } else {
                findView = emoticonView;
            }
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
    [self.emoticonViews enumerateObjectsUsingBlock:^(UIView *emoticonView, NSUInteger idx, BOOL *stop) {
        
        if (idx >= self.emoticons.count) {
            *stop = YES;
        }
        [emoticonView setFrame:({
            CGRectMake(marginHorizontal + emoticonViewWidth * (idx % HYTEmotionPageMaxCols),
                       marginVertical + emoticonViewHeight * (idx / HYTEmotionPageMaxCols),
                       emoticonViewWidth,
                       emoticonViewHeight);
            
        })];
    }];
    
    [self.deleteBtn setFrame:CGRectMake(self.width - marginHorizontal - emoticonViewWidth,
                                   self.height - emoticonViewHeight,
                                   emoticonViewWidth,
                                   emoticonViewHeight)];
}

@end
