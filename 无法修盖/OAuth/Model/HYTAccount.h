//
//  HYTAccount.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/24.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTAccount : NSObject <NSCoding>

/** 用户唯一标示ID */
@property (nonatomic, copy) NSString *userID;

/** 账户昵称 */
@property (nonatomic, copy) NSString *accountScreenName;

/** 访问标识 */
@property (nonatomic, copy) NSString *accessToken;

/** 标识的过期时长，单位为秒 */
@property (nonatomic, copy) NSString *expiresLength;

/** 创建时间 */
@property (nonatomic, strong) NSDate *expiresDate;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
