//
//  HYTAccountTool.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/24.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTAccountTool.h"

#define KAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AccountPath.data"]

@implementation HYTAccountTool

+ (void)saveAccountInfo:(HYTAccount *)account {
    
    [NSKeyedArchiver archiveRootObject:account toFile:KAccountPath];
}

+ (HYTAccount *)accountInfo {
    
    HYTAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:KAccountPath];
    if (account == nil) return nil;
    
    NSDate *nowDate = [NSDate date];

    //过期时间和当前时间相比若不为递增则为过期
    NSComparisonResult result = [account.expiresDate compare:nowDate];
    if (result != NSOrderedDescending)   return nil;

    return account;
}

@end
