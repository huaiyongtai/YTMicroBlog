//
//  UIBarButtonItem+Extension.h
//  无法修盖
//
//  Created by HelloWorld on 15/9/21.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/*
 *  @Parameter target               : 调用指定方法的对象
 *  @Parameter selector             : 调用的方法
 *  @Parameter imageName            : 普通状态图盘
 *  @Parameter highlightedImageName : 点击高亮时的图片
 *
 *  @return
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                           selector:(SEL)selector
                          imageName:(NSString *)imageName
               highlightedImageName:(NSString *)highlightedImageName;

@end
