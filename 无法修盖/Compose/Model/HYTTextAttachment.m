//
//  HYTTextAttachment.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/26.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTTextAttachment.h"
#import "HYTEmoticon.h"

@implementation HYTTextAttachment

+ (instancetype)attachment {
    return [[self alloc] init];
}

- (void)setEmoticon:(HYTEmoticon *)emoticon {
    
    _emoticon = emoticon;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"Emoticons.bundle/%@/%@", emoticon.idStr, emoticon.png]];
}

@end
