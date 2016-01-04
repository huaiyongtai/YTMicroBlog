//
//  HYMessageCenterController.m
//  无法修盖
//
//  Created by HelloWorld on 15/8/8.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYMessageCenterController.h"
#import "HYTest1ViewController.h"

@interface HYMessageCenterController ()

@end

@implementation HYMessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"写私信"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(writePersonalMsg)]];
    //没有消息时设置不可用（viewDidLoad方法是Lazy加载）
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    NSLog(@"%@ \n %@",  [[self.navigationItem rightBarButtonItem] titleTextAttributesForState:UIControlStateNormal],
          [[self.navigationItem rightBarButtonItem] titleTextAttributesForState:UIControlStateDisabled]);
}

- (void)writePersonalMsg {
    MBLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *reuseId = @"cellReuseId";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"section:%li-ror:%li", indexPath.section, indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HYTest1ViewController *test1 = [[HYTest1ViewController alloc] init];
    test1.view.frame = [UIScreen mainScreen].bounds;
    test1.navigationItem.title = @"test";
    test1.view.backgroundColor = [UIColor orangeColor];
//    [test1 setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:test1 animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
