//
//  HYTComposeToolbar.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/4.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYTComposeToolbarItemType) {
    HYTComposeToolbarItemPicture,
    HYTComposeToolbarItemMention,
    HYTComposeToolbarItemTrend,
    HYTComposeToolbarItemEmoticon,
    HYTComposeToolbarItemMore
};

@class HYTComposeToolbar;

@protocol HYTComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(HYTComposeToolbar *)toolbar didSelectedItemType:(HYTComposeToolbarItemType)itemType;

@end

@interface HYTComposeToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic, weak) id <HYTComposeToolbarDelegate> delegate;

@end
