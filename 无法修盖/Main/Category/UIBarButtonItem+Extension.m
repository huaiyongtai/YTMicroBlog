//
//  UIBarButtonItem+Extension.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/21.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target
                           selector:(SEL)selector
                          imageName:(NSString *)imageName
               highlightedImageName:(NSString *)highlightedImageName {
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [navBtn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [navBtn setBounds:CGRectMake(0, 0, navBtn.currentImage.size.width, navBtn.currentImage.size.height)];
    [navBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:navBtn];
}

@end
