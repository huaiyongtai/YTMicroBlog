//
//  HYTStatus.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/29.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTStatus.h"
#import "MJExtension.h"

@implementation HYTStatus

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"statusID"]) {
        return @"idstr";
    }
    
    if ([propertyName isEqualToString:@"pictures"]) {
        return @"pic_urls";
    }
    
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pictures" : [HYTPicture class]};
}


//重写创建时间
- (NSString *)createdAt {
    return @"1小时";
}


- (void)setSource:(NSString *)source {
    
//    _source = source;
    _source = @"我不是iPhone 10S Plus";
}




@end
