//
//  HYTEmoticonCell.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/8.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTEmoticon;

@interface HYTEmoticonCell : UICollectionViewCell

@property (nonatomic, strong) HYTEmoticon *emoticon;

@property (nonatomic, copy) NSString *title;

@end
