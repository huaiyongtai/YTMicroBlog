//
//  HYTStatus.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYTUser.h"

@interface HYTStatus : NSObject

/** 微博状态ID */
@property (nonatomic, copy) NSString *statusID;

/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博创建时间 */
@property (nonatomic, copy) NSString *createdAt;

/** 微博作者的用户信息 */
@property (nonatomic, strong) HYTUser *user;

//+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
