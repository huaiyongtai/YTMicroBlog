//
//  NSString+Extension.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)yt_sizeWithFont:(UIFont *)font {
    return [self yt_sizeWithFont:font maxWidth:SCREEN_WIDTH];
}
- (CGSize)yt_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [self yt_sizeWithFont:font maxSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
}
- (CGSize)yt_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attributes = @{NSFontAttributeName : font};

    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attributes
                              context:nil].size;
    
    
}

@end
