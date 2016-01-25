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

@property (nonatomic, weak) HYTEmoticonBtn *emoticonView;

@end

@implementation HYTEmoticonPopView

+ (instancetype)emoticonPopView {
    
    return [[self alloc] init];
}

- (instancetype)init {
    
    self = [super initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
    if (!self) return nil;

    HYTEmoticonBtn *emoticonView = [HYTEmoticonBtn emoticonBtn];
    [self addSubview:emoticonView];
    self.emoticonView = emoticonView;
    
    return self;
}

- (void)showEmoticon:(HYTEmoticon *)emoticon fromView:(UIView *)fromView {

    if (self.superview && self.emoticonView.emoticon == emoticon) {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    CGRect fromRect = [fromView convertRect:fromView.bounds toView:nil]; {
        if (fromRect.origin.x < 0 ) {
//            CGFloat x = fabsf(fromRect.origin.x);
//            x = window.width * ((int)(x / window.width) - x);
//            fromRect.origin.x = x;
//          ==
            CGFloat x = fromRect.origin.x;
            x =- window.width * (int)(x / window.width);
            fromRect.origin.x = x;
            
        }
    }
    
    [self setFrame:CGRectMake(fromRect.origin.x + (fromRect.size.width - self.width) * 0.5,
                              CGRectGetMaxY(fromRect) - self.height,
                              self.width,
                              self.height)];
    
    [self.emoticonView setEmoticon:emoticon];
    [self.emoticonView sizeToFit];
    [self.emoticonView setOrigin:CGPointMake((self.width-self.emoticonView.width) * 0.5, self.height-self.emoticonView.height)];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.emoticonView.y = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1 animations:^{
                             self.emoticonView.y = 8;
                         }];
                     }];

}

- (void)dismissViewFromSuper {
        [self removeFromSuperview];
}


@end
