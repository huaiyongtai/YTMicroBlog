//
//  HYTUser.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTUser.h"
#import "MJExtension.h"

@implementation HYTUser

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"userID" : @"idstr",
//             @"profileImageURL" : @"profile_image_url"};
//}

//当实现mj_replacedKeyFromPropertyName121方法后mj_replacedKeyFromPropertyName将不会被调用，只有当mj_replacedKeyFromPropertyName121返回nil时才调用mj_replacedKeyFromPropertyName；
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"userID"]) {
        return @"idstr";
    }
    
    if ([propertyName isEqualToString:@"profileImageURL"]) {
        return @"profile_image_url";
    }
    
    if ([propertyName isEqualToString:@"mbType"]) {
        return @"mbtype";
    }
    
    if ([propertyName isEqualToString:@"mbRank"]) {
        return @"mbrank";
    }
    return [propertyName mj_underlineFromCamel];
}

- (void)setMbType:(int)mbType {
    _mbType = mbType;
    
    self.vip = mbType > 2;
}


//+ (instancetype)userWithDict:(NSDictionary *)dict {
//    
//    HYTUser *user = [[HYTUser alloc] init];
//    user.userID = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profileImageURL = dict[@"profile_image_url"];
//    
//    return user;
//}
@end
