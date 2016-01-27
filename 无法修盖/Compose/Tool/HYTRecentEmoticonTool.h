//
//  HYTRecentEmoticonTool.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYTEmoticon;

@interface HYTRecentEmoticonTool : NSObject

+ (NSArray *)recentEmoticons;
+ (void)addEmoticonToRecentEmotions:(HYTEmoticon *)emoticon;
@end
