//
//  HYTStatus.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatus.h"
#import "HYTUser.h"

@implementation HYTStatus

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"statusID" : @"idstr"};
}

//+ (instancetype)statusWithDict:(NSDictionary *)dict {
//    
//    HYTStatus *status = [[HYTStatus alloc] init];
//    status.statusID = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [HYTUser userWithDict:dict[@"user"]];
//    
//    return status;
//}
@end
