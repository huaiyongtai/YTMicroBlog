//
//  HYTStatusFrame.h
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#define HYTStatusFrameNameFont [UIFont systemFontOfSize:15]

#import <Foundation/Foundation.h>
#import "HYTStatus.h"

@interface HYTStatusFrame : NSObject

/** 原创微博Frame */
@property (nonatomic, assign) CGRect originalStatusViewF;

/** 用户头像Frame */
@property (nonatomic, assign) CGRect profileImageViewF;

/** 用户昵称Frame */
@property (nonatomic, assign) CGRect nameLabelF;

/** 用户会员图标Frame */
@property (nonatomic, assign) CGRect mbMarkViewF;

/** 微博来源Frame */
@property (nonatomic, assign) CGRect sourceLabelF;

/** 微博创建时间Frame */
@property (nonatomic, assign) CGRect createdAtLabelF;

/** 微博信息内容Frame */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的总高度 */
@property (nonatomic, assign) CGFloat cellTotalHeight;

/** 微博模型 */
@property (nonatomic, strong) HYTStatus *status;

+ (instancetype)statusFrameWithStatus:(HYTStatus *)status;

@end
