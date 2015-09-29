//
//  HYTest1ViewController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTest1ViewController.h"
#import "HYTest2ViewController.h"

@interface HYTest1ViewController ()

@end

@implementation HYTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super didReceiveMemoryWarning];
    
    HYTest2ViewController *test2 = [[HYTest2ViewController alloc] init];
    test2.view.frame = [UIScreen mainScreen].bounds;
    test2.navigationItem.title = @"test2";
    test2.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:test2 animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

@end
