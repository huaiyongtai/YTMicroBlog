//
//  UIImage+Extension.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "UIImage+Extension.h"

typedef NS_ENUM(NSInteger, ResizableTypes) {
    ResizableTypeDefault = 1,
    ResizableTypeVertical = 2,
    ResizableTypeHorizontal
};

@implementation UIImage (Extension)

+ (UIImage *)imageWithResizableImageName:(NSString *)imageName {
    return [self imageWithResizableImageName:imageName orientation:ResizableTypeDefault];
}

+ (UIImage *)imageWithResizableVerticalImageName:(NSString *)imageName {
    return [self imageWithResizableImageName:imageName orientation:ResizableTypeVertical];
}

+ (UIImage *)imageWithResizableHorizontalImageName:(NSString *)imageName {
   return [self imageWithResizableImageName:imageName orientation:ResizableTypeHorizontal];
}

+ (UIImage *)imageWithResizableImageName:(NSString *)imageName orientation:(ResizableTypes)resizableType {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    //水平方向保护
    CGFloat horizontal = 0;
    //竖直方向保护
    CGFloat vertical   = 0;
    
    switch (resizableType) {
        case ResizableTypeDefault: {
            horizontal = image.size.width*0.5 - 0.5;
            vertical   = image.size.height*0.5 - 0.5;
            break;
        }
        case ResizableTypeVertical: {
            vertical = image.size.height*0.5 - 0.5;
            break;
        }
        case ResizableTypeHorizontal: {
            horizontal = image.size.width*0.5 - 0.5;
            break;
        }
        default: {
            break;
        }
    }
    
    UIEdgeInsets edgeInsets =  UIEdgeInsetsMake(vertical, horizontal, vertical, horizontal);
    return [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
}

@end
