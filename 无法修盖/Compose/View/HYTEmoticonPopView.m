//
//  HYTEmoticonPopView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/25.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonPopView.h"
#import "HYTEmoticonBtn.h"

@interface HYTEmoticonPopView ()

@property (nonatomic, weak) UIView *emoticonView;

@end

@implementation HYTEmoticonPopView

+ (instancetype)emoticonPopView {
    
    return [[self alloc] init];
}

- (instancetype)init {
    
    self = [super initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
    if (!self) return nil;

    return self;
}

- (void)showEmoticon:(HYTEmoticon *)emoticon fromView:(UIView *)fromView {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect fromRect = [fromView convertRect:fromView.bounds toView:window];
    [self setFrame:CGRectMake(fromRect.origin.x + (fromRect.size.width - self.width) * 0.5,
                              CGRectGetMaxY(fromRect) - self.height,
                              self.width,
                              self.height)];
    
    HYTEmoticonBtn *emoticonView = [HYTEmoticonBtn emoticonBtn];
    [emoticonView setEmoticon:emoticon];;
    [emoticonView sizeToFit];
    [emoticonView setOrigin:CGPointMake((self.width-emoticonView.width) * 0.5, self.height-emoticonView.height)];
    [self addSubview:emoticonView];
    self.emoticonView = emoticonView;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        emoticonView.y = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            emoticonView.y = 8;
        }];
    }];
}

- (void)dismissView {
    
    [self removeFromSuperview];
    
    [self.emoticonView removeFromSuperview];
}


@end
