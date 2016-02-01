//
//  HYTEmoticonBtn.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/24.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonBtn.h"
#import "HYTEmoticon.h"

@implementation HYTEmoticonBtn

+ (instancetype)emoticonBtn {
    
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:32]];

    return self;
}

- (void)setHighlighted:(BOOL)highlighted {};

- (void)setEmoticon:(HYTEmoticon *)emoticon {
    
    _emoticon = emoticon;
    
    [self setImage:[UIImage imageNamed:({
        [NSString stringWithFormat:@"Emoticons.bundle/%@/%@", emoticon.idStr, emoticon.png];
    })] forState:UIControlStateNormal];
    
    [self setTitle:emoticon.code.emoji forState:UIControlStateNormal];
}

- (void)setHidden:(BOOL)hidden {
    
    [super setHidden:hidden];
    
    self.enabled = !hidden;
}

@end
