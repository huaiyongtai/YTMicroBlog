//
//  HYTUser.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HYTUserVerifiedTypes) {
    
    HYTUserVerifiedNone       = -1,    //无任何认证
    HYTUserVerifiedPersonal   = 2,     //个人认证
    HYTUserVerifiedEnterprise = 3,     //企业认证
    HYTUserVerifiedGrassroot  = 10,    //微博达人
    HYTUserVerifiedGirl
    
};

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

/** 用户认证类型 */
@property (nonatomic, assign) HYTUserVerifiedTypes verifiedType;

//+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
