
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
#import "AFNetworking.h"
#import "HYTAccountTool.h"
#import "UIImageView+WebCache.h"
#import "HYTUser.h"
#import "HYTStatus.h"
#import "MJExtension.h"

@interface HYHomePageController () <DropDownMenuDelegate>

/** 微博模型属性 */
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation HYHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statuses = [NSMutableArray array];
    
    [self setupNavInfo];
    
    [self setupNavTitle];
    
    [self setupStatus];
}

/** 设置导航栏信息 */
- (void)setupNavInfo {
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
    
    //导航标题View
    NSString *screenName = [HYTAccountTool accountInfo].accountScreenName;
    
    NavTitleBtn *customBtn = [NavTitleBtn buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [customBtn setTitle:screenName ? screenName : @"首页" forState:UIControlStateNormal];
    [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [customBtn setFrame:CGRectMake(0, 0, 200, 40)];
    [customBtn addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:customBtn];
}
/** 设置导航标题 */
- (void)setupNavTitle {
    
    HYTAccount *account = [HYTAccountTool accountInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.accessToken;
    parameters[@"uid"] = account.userID;
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:@"https://api.weibo.com/2/users/show.json"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             HYTUser *user = [HYTUser mj_objectWithKeyValues:responseObject];
             
             //与上次昵称相同则直接返回
             if ([user.name isEqualToString:account.accountScreenName]) return;
             
             account.accountScreenName = user.name;
             NavTitleBtn *navTitle = (NavTitleBtn *)self.navigationItem.titleView;
             [navTitle setTitle:account.accountScreenName forState:UIControlStateNormal];
             [HYTAccountTool saveAccountInfo:account];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error:%@", error);
         }
     ];

    
    
}
/** 设置微博数据 */
- (void)setupStatus {
    
    HYTAccount *account = [HYTAccountTool accountInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.accessToken;
    parameters[@"count"] = @20;
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSArray *statuesArray =  responseObject[@"statuses"];
//            for (NSDictionary *statuesDict in statuesArray) {
//                HYTStatus *statues = [HYTStatus mj_objectWithKeyValues:statuesDict];
//                [self.statuses addObject:statues];
//            }
            
            //将字典数组转化为模型数组
            self.statuses = [HYTStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
            
            //刷新表格
            [self.tableView reloadData];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error:%@", error);
        }
     ];
}

- (void)dropMenu:(UIButton *)btn {
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseID = @"statuses";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:reuseID];
    }
    
    HYTStatus *states = self.statuses[indexPath.row];
    HYTUser *user = states.user;
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = states.text;
    
    
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profileImageURL] placeholderImage:placeholderImage];
    
    return cell;
}


@end
