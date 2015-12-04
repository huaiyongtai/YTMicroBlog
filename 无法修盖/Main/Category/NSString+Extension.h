//
//  NSString+Extension.h
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)yt_sizeWithFont:(UIFont *)font;

- (CGSize)yt_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)yt_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
