//
//  HYTEmoticonPopView.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/25.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTEmoticon;

@interface HYTEmoticonPopView : UIImageView

+ (instancetype)emoticonPopView;

- (void)showEmoticon:(HYTEmoticon *)emoticon fromView:(UIView *)fromView;

- (void)showEmoticon:(HYTEmoticon *)emoticon fromView:(UIView *)fromView delay:(NSTimeInterval)delay completion:(void(^)(void))completion;

@end
