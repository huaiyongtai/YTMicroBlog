//
//  HYHomePageController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYHomePageController.h"
#import "DropDownMenu.h"
#import "NavTitleBtn.h"

@interface HYHomePageController () <DropDownMenuDelegate>

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
                                                          highlightedImageName:@"navigationbar_pop_highlighted"]];
    
    NavTitleBtn *customBtn = [NavTitleBtn buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [customBtn setTitle:@"首页" forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [customBtn setFrame:CGRectMake(0, 0, 200, 40)];
    [customBtn addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:customBtn];
    
}

- (void)dropMenu:(UIButton *)btn {

    NSString *title = @"你啊可连接的法律可点击付款较";
    title = [title substringFromIndex:arc4random_uniform(title.length)];
    [btn setTitle:title forState:UIControlStateNormal];
    
    DropDownMenu *menu = [DropDownMenu menu];
    menu.delegate = self;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [contentView setBackgroundColor:[UIColor redColor]];
    [menu setContentView:contentView];
    [menu showFromView:btn];
}

#pragma mark - DropDownMenuDelegate
- (void)dropDownMenuDidShowMenu:(DropDownMenu *)menu {
    
    UIButton *navTitleBtn = (UIButton *)self.navigationItem.titleView;
    [navTitleBtn setSelected:YES];
    
    
}
- (void)dropDownMenuDidDismissMenu:(DropDownMenu *)menu {
    UIButton *navTitleBtn = (UIButton *)self.navigationItem.titleView;
    [navTitleBtn setSelected:NO];
}

- (void)friendSearch {
    
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)pop {
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}



@end
