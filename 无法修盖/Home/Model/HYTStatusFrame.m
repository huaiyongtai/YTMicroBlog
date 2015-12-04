//
//  HYTStatusFrame.m
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatusFrame.h"

@implementation HYTStatusFrame

+ (instancetype)statusFrameWithStatus:(HYTStatus *)status {
    
    HYTStatusFrame *statusFrame = [[self alloc] init];
    statusFrame.status = status;
    return statusFrame;
}

- (void)setStatus:(HYTStatus *)status {
    
    _status = status;
    HYTUser *user = status.user;
    
    CGFloat verticalMargin = 25;    //距离边框的水平距离
    CGFloat horizontalMargin = 20;  //距离边框的竖直距离
    CGFloat verticalPadding = 20;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
