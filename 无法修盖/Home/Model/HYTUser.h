//
//  HYTUser.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTUser : NSObject

/** 用户ID */
@property (nonatomic, copy) NSString *userID;

/** 用户昵称 */
@property (nonatomic, copy) NSString *name;

/** 用户头像URL */
@property (nonatomic, copy) NSString *profileImageURL;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbType;
/** 会员等级 */
@property (nonatomic, assign) int mbRank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

//+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
