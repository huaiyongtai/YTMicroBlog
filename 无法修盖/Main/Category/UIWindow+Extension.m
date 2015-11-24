//
//  UIWindow+Extension.m
//  无法修盖
//
//  Created by HelloWorld on 15/11/24.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HYTabbarController.h"
#import "HYTNewFeatureController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController {
    
    NSString *versionKey = @"CFBundleVersion";
    
    //1.拿到当前软件版本号
    //只有这个方法才能拿到我们的info.plist,如：[[NSBundle mainBundle] pathForResource:@"info" ofType:@"plist"] 无法拿到
    NSDictionary *bundleInfo = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = bundleInfo[versionKey];
    
    //2.拿到沙盒存储的上一次版本号
    NSUserDefaults *userDefalut = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefalut valueForKey:versionKey];
    
    //3.上一次版本号与当前软件版本好比较
    if ([currentVersion isEqualToString:lastVersion]) { //不显示新特性
        HYTabbarController *tabbarController = [[HYTabbarController alloc] init];
        [self setRootViewController:tabbarController]; 
    } else {    //不同显示新特性
        
        //3.1 设置新特性界面
        HYTNewFeatureController *newFeatureController = [[HYTNewFeatureController alloc] init];
        [self setRootViewController:newFeatureController];
        
        //3.2 将当前软件版本号存储
        [userDefalut setValue:currentVersion forKey:versionKey];
        [userDefalut synchronize];
    }
}

@end
