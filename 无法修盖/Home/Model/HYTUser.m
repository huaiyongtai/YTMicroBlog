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

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userID" : @"idstr",
             @"profileImageURL" : @"profile_image_url"};
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
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
