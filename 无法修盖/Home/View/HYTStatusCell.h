//
//  HYTStatusCell.h
//  无法修盖
//
//  Created by HelloWorld on 15/12/4.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTStatusFrame;

@interface HYTStatusCell : UITableViewCell

/** 微博的Frame模型 */
@property (nonatomic, strong) HYTStatusFrame *statueFrame;

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
