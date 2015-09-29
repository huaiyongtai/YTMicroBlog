//
//  HYNavigationController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/9.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYNavigationController.h"

@interface HYNavigationController ()

@end

@implementation HYNavigationController : UINavigationController

+ (void)initialize {
    
    //设置所有UIBarButtonItem的主题样式
    UIBarButtonItem *navBarItem = [UIBarButtonItem appearance];
    
    //普通状态
    NSDictionary *normalDict =  @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                  NSForegroundColorAttributeName : [UIColor orangeColor]};
    [navBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    
    //不可用状态
    NSDictionary *disableDict = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                  NSForegroundColorAttributeName : [UIColor brownColor]};
    [navBarItem setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count>0) {
        //push操作时隐藏底部Tabbar **这句要在push操作之前，若在push操作之后将效果
        [viewController setHidesBottomBarWhenPushed:YES];
        
        //导航栏左侧按钮
        [viewController.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self
                                                                                   selector:@selector(backPreController)
                                                                                  imageName:@"navigationbar_back"
                                                                       highlightedImageName:@"navigationbar_back_highlighted"]];
        
        //导航栏右侧按钮
        [viewController.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self
                                                                                    selector:@selector(goRootViewController)
                                                                                   imageName:@"navigationbar_more"
                                                                        highlightedImageName:@"navigationbar_more_disable"]];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

//返回到上一个控制器
- (void)backPreController {
    [self popViewControllerAnimated:YES];
}

//返回到根控制器
- (void)goRootViewController {
    [self popToRootViewControllerAnimated:YES];
}

@end
