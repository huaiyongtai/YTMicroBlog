//
//  HYTEmoticonPackage.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/24.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTEmoticonPackage : NSObject

@property (nonatomic, copy, readonly) NSString *idStr;

@property (nonatomic, strong, readonly) NSArray *emoticons;

+ (instancetype)emoticonPackageWithPackageIdStr:(NSString *)emoticonIdStr;
- (instancetype)initWithPackageIdStr:(NSString *)emoticonIdStr;

@end
