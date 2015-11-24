//
//  HYTAccountTool.h
//  无法修盖
//
//  Created by HelloWorld on 15/11/24.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYTAccount;

@interface HYTAccountTool : NSObject

+ (void)saveAccountInfo:(HYTAccount *)account;

+ (HYTAccount *)accountInfo;

@end
