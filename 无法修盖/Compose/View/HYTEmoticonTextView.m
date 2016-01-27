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

- (void)insertEmoticon:(HYTEmoticon *)emoticon {
    
    if (emoticon.png) {
        
        HYTTextAttachment *attchEmoticon = [HYTTextAttachment attachment];
        attchEmoticon.emoticon = emoticon;
        attchEmoticon.bounds = CGRectMake(0, -5, self.font.lineHeight+1.5f, self.font.lineHeight+1.5f);
        NSAttributedString *emoticonStr = [NSAttributedString attributedStringWithAttachment:attchEmoticon];
        
        [self insertAttributedText:emoticonStr willComplete:^(NSMutableAttributedString *insertedAttText) {
            [insertedAttText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, insertedAttText.length)];
        }];
        
    } else {
        [self insertText:emoticon.code.emoji];
    }
}

- (NSString *)plainText {
    
    NSMutableString *statusText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length)
                                            options:0
                                         usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                                             HYTTextAttachment *textAttach = attrs[@"NSAttachment"];
                                             if (textAttach) {
                                                 [statusText appendString:textAttach.emoticon.chs];
                                             } else {
                                                 [statusText appendString:[self.attributedText attributedSubstringFromRange:range].string];
                                             }
                                         }];
    return statusText;
}

@end
