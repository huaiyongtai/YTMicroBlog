//
//  HYTHttpTool.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYTHttpFile.h"

@interface HYTHttpTool : NSObject

/** 发送GET请求 */
+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)get:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/** 发送POST请求 */
+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/** 以POST形式上传文件 */
+ (void)post:(NSString *)url parameters:(id)parameters uploadFiles:(NSArray <HYTHttpFile *> * )files success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(id)parameters uploadFiles:(NSArray <HYTHttpFile *> * )files uploadProgressBlock:(void(^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
