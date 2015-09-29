//
//  HYTabbarController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/9.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTabbarController.h"
#import "HYHomePageController.h"
#import "HYMessageCenterController.h"
#import "HYDiscoverController.h"
#import "HYProflieController.h"
#import "HYNavigationController.h"

@interface HYTabbarController ()

@end

@implementation HYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYHomePageController *homePageController = [[HYHomePageController alloc] init];
    [self addChildViewController:homePageController
                           title:@"首页"
                       imageName:@"tabbar_home"
               selectedImageName:@"tabbar_home_selected"];
    
    HYMessageCenterController *messageCenterController = [[HYMessageCenterController alloc] init];
    [self addChildViewController:messageCenterController
                           title:@"消息"
                       imageName:@"tabbar_message_center"
               selectedImageName:@"tabbar_message_center_selected"];
    
    HYDiscoverController *discoverController = [[HYDiscoverController alloc] init];
    [self addChildViewController:discoverController
                           title:@"发现"
                       imageName:@"tabbar_discover"
               selectedImageName:@"tabbar_discover_selected"];
    
    HYProflieController *proflieController = [[HYProflieController alloc] init];
    [self addChildViewController:proflieController
                           title:@"我"
                       imageName:@"tabbar_profile"
               selectedImageName:@"tabbar_profile_selected"];

}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //=========tabbar特定样式设置=========
    //方式一
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    NSDictionary *tabbarTitleAttibutes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    NSDictionary *tabbarSelectTitleAttributes = @{NSForegroundColorAttributeName:[UIColor brownColor]};
    [childController.tabBarItem setTitleTextAttributes:tabbarTitleAttibutes forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:tabbarSelectTitleAttributes forState:UIControlStateSelected];
    
    //方式二
    /*
    [childController.tabBarItem setTitle:title];
    NSDictionary *tabbarTitleAttibutes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    NSDictionary *tabbarSelectTitleAttributes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    [childController.tabBarItem setTitleTextAttributes:tabbarTitleAttibutes forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:tabbarSelectTitleAttributes forState:UIControlStateSelected];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setImage:image];
    [childController.tabBarItem setSelectedImage:selectedImage];
    */
    
    HYNavigationController *navigation = [[HYNavigationController alloc] initWithRootViewController:childController];
    childController.navigationItem.title = title;
//    childController.title = title; //可以同时设定tabbarItem.title和navigation.title的值
    
    //navigation的Item,即navigation的navigationController标题
    //navigation.navigationItem.title = title; error
    
    [self addChildViewController:navigation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
