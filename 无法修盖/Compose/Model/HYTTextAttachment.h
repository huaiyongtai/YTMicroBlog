//
//  HYTTextAttachment.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/26.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTEmoticon;

@interface HYTTextAttachment : NSTextAttachment

@property (nonatomic, strong) HYTEmoticon *emoticon;

+ (instancetype)attachment;

@end
