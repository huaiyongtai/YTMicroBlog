//
//  AppDelegate.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "AppDelegate.h"
#import "HYTOAuthViewController.h"
#import "HYTAccountTool.h"
#import "HYTAccount.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    
    HYTAccount *account = [HYTAccountTool accountInfo];
    if (account == nil) {   //账号信息不合法
        self.window.rootViewController = [[HYTOAuthViewController alloc] init];
    } else {    
        [self.window switchRootViewController];
    }
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


#pragma mark - 当程序收到内存警告时将处理
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

    SDWebImageManager *sdMgr = [SDWebImageManager sharedManager];
    //1.取消所有下载
    [sdMgr cancelAll];
    
    //2.清除内存
    [sdMgr.imageCache clearMemory];
}

@end
