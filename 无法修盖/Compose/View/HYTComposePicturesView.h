//
//  HYTComposePicturesView.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/5.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTComposePicturesView : UIView

+ (instancetype)picturesView;

- (NSArray *)pictures;

- (void)addImageWithKey:(NSString *)key valueImage:(UIImage *)valueImage;

@end
