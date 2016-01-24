//
//  HYTEmoticonCell.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/8.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonCell.h"
#import "HYTEmoticon.h"

@interface HYTEmoticonCell ()

@property (nonatomic, weak) UILabel *emoticonLabel;

@end

@implementation HYTEmoticonCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *emoticonLabel = [[UILabel alloc] init];
        [emoticonLabel setNumberOfLines:0];
        [emoticonLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.contentView addSubview:emoticonLabel];
        self.emoticonLabel = emoticonLabel;
    }
    return self;
}

- (void)setEmoticon:(HYTEmoticon *)emoticon {
    
    _emoticon = emoticon;
    [self setUserInteractionEnabled:YES];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"Emoticons.bundle/com.sina.default/%@", emoticon.png]];
    NSAttributedString *attStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self.emoticonLabel setAttributedText:attStr];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    if (!title.length) {
        [self.emoticonLabel setAttributedText:nil];
        [self setUserInteractionEnabled:NO];
        return;
    }
    [self setUserInteractionEnabled:YES];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"compose_emotion_delete"];
    NSAttributedString *attStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self.emoticonLabel setAttributedText:attStr];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.emoticonLabel setFrame:self.bounds];

}

@end
