//
//  HYHomePageController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYHomePageController.h"

@interface HYHomePageController ()

@end

@implementation HYHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏左侧按钮
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self
                                                                     selector:@selector(friendSearch)
                                                                    imageName:@"navigationbar_friendsearch"
                                                         highlightedImageName:@"navigationbar_friendsearch_highlighted"]];
    
    //导航栏右侧按钮
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self
                                                                      selector:@selector(pop)
                                                                     imageName:@"navigationbar_pop"
                                                          highlightedImageName:@"navigationbar_pop_highlighted"]];;
}

- (UIBarButtonItem *)itemWithTarget:(id)target sel:(SEL)selector imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName {
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [navBtn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [navBtn setBounds:CGRectMake(0, 0, navBtn.currentImage.size.width, navBtn.currentImage.size.height)];
    [navBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:navBtn];
}

- (void)friendSearch {
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)pop {
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}



@end
