//
//  HYTEmoticonPackage.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/24.
//  Copyright (c) 2016年 SearchPrefect. All rights reserved.
//

#import "HYTEmoticonPackage.h"
#import "MJExtension.h"
#import "HYTEmoticon.h"

@implementation HYTEmoticonPackage

+ (instancetype)emoticonPackageWithPackageIdStr:(NSString *)emoticonIdStr {
    
    HYTEmoticonPackage *package = [[self alloc] initWithPackageIdStr:emoticonIdStr];
    
    return package;
}

- (instancetype)initWithPackageIdStr:(NSString *)emoticonIdStr {
    
    self = [super init];
    if (!self) return nil;
    
    _idStr = emoticonIdStr;
    
    _emoticons = [HYTEmoticon mj_objectArrayWithKeyValuesArray:({
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil];
        path = [path stringByAppendingFormat:@"/%@/info.plist", emoticonIdStr];
        NSArray *emoticonArray = [NSDictionary dictionaryWithContentsOfFile:path][@"emoticons"];
        emoticonArray;
    })];
    
    return self;
}


@end