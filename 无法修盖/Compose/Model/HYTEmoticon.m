//
//  HYTEmoticon.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/7.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticon.h"
#import "MJExtension.h"

@implementation HYTEmoticon

MJCodingImplementation


//- (id)initWithCoder:(NSCoder *)decoder 
//{
//    if (self = [super init]) {
//        [self mj_decode:decoder];
//    }
//    return self;
//}
//\
//- (void)encodeWithCoder:(NSCoder *)encoder \
//{ \
//    [self mj_encode:encoder]; \
//}

- (BOOL)isEqual:(id)object {
    
    BOOL equal = [super isEqual:object];
    
    if (equal) return YES;
    
    HYTEmoticon *emoticon = object;
    if (![emoticon isKindOfClass:[HYTEmoticon class]]) return NO;
    
    //向一个空的对象发送消息肯定是nil
    return [self.code isEqualToString:emoticon.code] || [self.chs isEqualToString:emoticon.chs];
}

@end
