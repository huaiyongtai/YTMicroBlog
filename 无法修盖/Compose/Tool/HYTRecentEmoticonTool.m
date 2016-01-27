//
//  HYTRecentEmoticonTool.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTRecentEmoticonTool.h"

#define kRecentEmoticonsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmoticonTool.date"]

static NSMutableArray *emoticons = nil;

@implementation HYTRecentEmoticonTool

+ (void)initialize {
    
    [super initialize];
    
    emoticons = [NSKeyedUnarchiver unarchiveObjectWithFile:kRecentEmoticonsPath];
    if (!emoticons) {
        emoticons = [NSMutableArray array];
    }
    
}

+ (NSArray *)recentEmoticons {

    return emoticons;
}

+ (void)addEmoticonToRecentEmotions:(HYTEmoticon *)emoticon {
    
    [emoticons removeObject:emoticon];
    
    [emoticons insertObject:emoticon atIndex:0];
    
    if (emoticons.count > 20) {
        [emoticons removeLastObject];
    }
    [NSKeyedArchiver archiveRootObject:emoticons toFile:kRecentEmoticonsPath];
}

@end
