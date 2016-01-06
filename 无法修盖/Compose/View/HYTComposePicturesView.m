//
//  HYTComposePicturesView.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/5.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTComposePicturesView.h"

@interface HYTComposePicturesView ()

@property (nonatomic, strong) NSMutableDictionary *pictureViews;

@end

@implementation HYTComposePicturesView

+ (instancetype)picturesView {
    
    HYTComposePicturesView *picturesView = [[self alloc] init];
    return picturesView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _pictureViews = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray *)pictures {
    
    NSMutableArray *pictures = [NSMutableArray array];
    [self.pictureViews enumerateKeysAndObjectsUsingBlock:^(id key, UIImageView *imageView, BOOL *stop) {
        if (imageView.image) {
            [pictures addObject:imageView.image];
        }
    }];
    return pictures;
}

- (void)addImageWithKey:(NSString *)key valueImage:(UIImage *)valueImage {
    
    
    if (self.pictureViews.count > 9) {
        [HYTAlertView showAlertMsg:@"您对多能选9张"];
        return;
    }
    
    if ([self.pictureViews objectForKey:key]) { //以前选择过，不存储
        [HYTAlertView showAlertMsg:@"您已经选择了该图片"];
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:valueImage];
    [self addSubview:imageView];
    [self.pictureViews setObject:imageView forKey:key];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSDictionary *pictures = self.pictureViews;
    NSUInteger cols = 3;
    NSUInteger padding = 10;
    CGFloat imageViewWH = (self.width - (cols+1)*padding) / cols;
    NSArray *imageKey = [pictures allKeys];
    for (NSUInteger index = 0; index<pictures.count; index++) {
        UIImageView *imageView = pictures[imageKey[index]];
        [imageView setFrame:CGRectMake(index % cols * (imageViewWH + padding) + padding,
                                       index / cols * (imageViewWH + padding) + padding,
                                       imageViewWH,
                                       imageViewWH)];
    }
}





@end
