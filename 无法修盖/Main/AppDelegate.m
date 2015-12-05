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
    
    if ([[UIDevice currentDevice]systemVersion].floatValue>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
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
    
    /*应用程序一般有四种状态
     * 1.死亡状态、没有开启
     * 2.前台运行状态
     * 3.后台暂停状态 （将终止动画、多媒体、网络请求等一系列操作）
     * 4.后天运行状态
     */
    
    //一、
    //申请后台任务的运行（运行的时长由iOS系统来决定）
    UIBackgroundTaskIdentifier taskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台运行时间过期，便会调用该（ExpirationHandler）Blook
        
        //结束后台任务
        [application endBackgroundTask:taskIdentifier];
        
    }];
    
    //二、
    /* 0. 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay（表示我们的后台任务是音频）
     * 1. 搞一个0kb的MP3文件，没有声音 （不影响我们的应用）
     * 2. 循环播放 （系统会检测我们有没有真的在播放）
     */
    
    
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
