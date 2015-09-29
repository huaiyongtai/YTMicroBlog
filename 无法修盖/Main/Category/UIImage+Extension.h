//
//  UIImage+Extension.h
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithResizableImageName:(NSString *)imageName;

+ (UIImage *)imageWithResizableVerticalImageName:(NSString *)imageName;

+ (UIImage *)imageWithResizableHorizontalImageName:(NSString *)imageName;

@end
