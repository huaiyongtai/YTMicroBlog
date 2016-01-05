//
//  HYTComposePicturesView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/5.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTComposePicturesView.h"

@interface HYTComposePicturesView ()

@property (nonatomic, strong) NSMutableDictionary *pictures;

@end

@implementation HYTComposePicturesView

+ (instancetype)picturesView {
    
    HYTComposePicturesView *picturesView = [[self alloc] init];
    return picturesView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _pictures = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addImageWithKey:(NSString *)key valueImage:(UIImage *)valueImage {
    
    if ([self.pictures objectForKey:key]) { //以前选择过，不存储
        [HYTAlertView showAlertMsg:@"您已经选择了该图片"];
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:valueImage];
    [self addSubview:imageView];
    [self.pictures setObject:imageView forKey:key];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSDictionary *pictures = self.pictures;
    NSArray *imageKey = [pictures allKeys];
    NSUInteger cols = 3;
    NSUInteger padding = 10;
    CGFloat imageViewWH = (self.width - (cols-1)*padding) / cols;
    for (NSUInteger index = 0; index<pictures.count; index++) {
        UIImageView *imageView = pictures[imageKey[index]];
        [imageView setFrame:CGRectMake(index % cols * (imageViewWH + padding), index / cols * (imageViewWH + padding), imageViewWH, imageViewWH)];
    }
}





@end
