//
//  HYTTextView.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/31.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTTextView.h"

@implementation HYTTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _placeholderColor = HYTCOLOR(129, 129, 129);
        self.font = [UIFont systemFontOfSize:16];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textDidChange)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];    //此处我们只监听我们自己text变化，故我们传入self
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect  {
    
    [super drawRect:rect];
    if (self.hasText) return;   //当重新绘制时会擦掉以前所有画的东西
    
    NSDictionary *attr = @{NSFontAttributeName : self.font,
                           NSForegroundColorAttributeName : self.placeholderColor};
    [self.placeholder drawInRect:CGRectMake(5, 8, rect.size.width-10, rect.size.height) withAttributes:attr];
}

- (void)textDidChange {
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


#pragma mark - 重写setter方法，保证实时变化
- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
