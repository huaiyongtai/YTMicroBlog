//
//  HYSearchBar.m
//  无法修盖
//
//  Created by HelloWorld on 15/9/23.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYSearchBar.h"

@implementation HYSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //设置左边视图（图片的伸缩在 图片属性中设置了）
        [self setBackground:[UIImage imageNamed:@"search_navigationbar_textfield_background"]];
        
        //设置左边视图放大镜
        UIImageView *searchIcom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        [searchIcom setFrame:CGRectMake(0, 0, 30, 30)];
        [searchIcom setContentMode:UIViewContentModeCenter];
        [self setLeftView:searchIcom];
        [self setLeftViewMode:UITextFieldViewModeAlways];
        
    }
    return self;
}

+ (instancetype)searchBar {
    
    return [[self alloc] init];
}

@end
