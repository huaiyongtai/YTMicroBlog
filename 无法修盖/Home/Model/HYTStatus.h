//
//  HYTStatus.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYTUser.h"
#import "HYTStatusPicture.h"

@interface HYTStatus : NSObject

/** 微博状态ID */
@property (nonatomic, copy) NSString *statusID;

/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博创建时间 */
@property (nonatomic, copy) NSString *createdAt;

/** 转发数 */
@property (nonatomic, copy) NSString *repostsCount;

/** 评论数 */
@property (nonatomic, copy) NSString *commentsCount;

/** 表态数 */
@property (nonatomic, copy) NSString *attitudesCount;

/** 配图模型数组 */
@property (nonatomic, strong) NSArray *pictures;

/** 微博作者的用户信息 */
@property (nonatomic, strong) HYTUser *user;

/** 转发微博 */
@property (nonatomic, strong) HYTStatus *retweetedStatus;

//+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
