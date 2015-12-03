//
//  HYTAccount.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/24.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTAccount.h"

@implementation HYTAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    
    HYTAccount *account = [[HYTAccount alloc] init];
    
    account.accountID =  dict[@"uid"];
    account.expiresLength =  dict[@"expires_in"];
    account.accessToken =  dict[@"access_token"];
    
    NSDate *expiresData = [[NSDate date] dateByAddingTimeInterval:account.expiresLength.integerValue];
    account.expiresDate = expiresData;

    return account;
}

#pragma mark - 解档时要解档的内容
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.accountID = [aDecoder decodeObjectForKey:@"accountID"];
        self.expiresLength = [aDecoder decodeObjectForKey:@"expiresLength"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.expiresDate = [aDecoder decodeObjectForKey:@"expiresData"];
        self.accountScreenName = [aDecoder decodeObjectForKey:@"accountScreenName"];
    }
    return self;
}

#pragma mark - 归档时要归档内容
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.accountID forKey:@"accountID"];
    [aCoder encodeObject:self.expiresLength forKey:@"expiresLength"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.expiresDate forKey:@"expiresData"];
    [aCoder encodeObject:self.accountScreenName forKey:@"accountScreenName"];
}

@end
