//
//  HYTHttpTool.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYTHttpUpload.h"

@interface HYTHttpTool : NSObject

+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(id)parameters files:(NSArray <HYTHttpUpload *> * )files success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
