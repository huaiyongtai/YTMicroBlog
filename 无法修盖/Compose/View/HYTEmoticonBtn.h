//
//  HYTEmoticonBtn.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/24.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTEmoticon;

@interface HYTEmoticonBtn : UIButton

+ (instancetype)emoticonBtn;

@property (nonatomic, strong) HYTEmoticon *emoticon;

@end
