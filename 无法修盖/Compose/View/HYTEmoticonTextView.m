//
//  HYTEmoticonTextView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/26.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonTextView.h"
#import "HYTTextAttachment.h"
#import "HYTEmoticon.h"


@implementation HYTEmoticonTextView

- (void)setEmoticon:(HYTEmoticon *)emoticon {
    
    _emoticon = emoticon;
    
    if (emoticon.png) {
        
        NSMutableAttributedString *arrText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        HYTTextAttachment *attchEmoticon = [HYTTextAttachment attachment];
        attchEmoticon.emoticon = emoticon;
        attchEmoticon.bounds = CGRectMake(0, -5, self.font.lineHeight+1.5f, self.font.lineHeight+1.5f);
        NSAttributedString *emoticonStr = [NSAttributedString attributedStringWithAttachment:attchEmoticon];
        
        NSRange selectedRange = self.selectedRange;
        [arrText replaceCharactersInRange:selectedRange withAttributedString:emoticonStr];
        [arrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, arrText.length)];
        self.attributedText = arrText;
        self.selectedRange = NSMakeRange(selectedRange.location+1, 0);
        
    } else {
        [self insertText:emoticon.code.emoji];
    }
}

@end
