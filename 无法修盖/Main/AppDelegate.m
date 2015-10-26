//
//  AppDelegate.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "AppDelegate.h"
#import "HYTabbarController.h"
#import "HYTNewFeatureController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    
    /*
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
        [self.window setRootViewController:tabbarController];
        
    } else {    //不同显示新特性
        
        //3.1 设置新特性界面
        HYTNewFeatureController *newFeatureController = [[HYTNewFeatureController alloc] init];
        [self.window setRootViewController:newFeatureController];
        
        //3.2 将当前软件版本号存储
        [userDefalut setValue:currentVersion forKey:versionKey];
        [userDefalut synchronize];
    }
    */
    
    self.window.rootViewController = [[HYTabbarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
