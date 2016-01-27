//
//  UITextView+Extension.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)attributedText {
    
    [self insertAttributedText:attributedText willComplete:nil];
}

- (void)insertAttributedText:(NSAttributedString *)attributedText willComplete:(void(^)(NSMutableAttributedString *insertedAttText))willComplete {
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    //拿到光标，以确定插入位置
    NSRange selectedRange = self.selectedRange;
    
    //插入
    [attText replaceCharactersInRange:selectedRange withAttributedString:attributedText];
    
    if (willComplete) {
        willComplete(attText);
    }
    
    self.attributedText = attText;
    
    //光标下移
    self.selectedRange = NSMakeRange(selectedRange.location+1, 0);
}

@end
