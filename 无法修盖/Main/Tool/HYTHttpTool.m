//
//  HYTHttpTool.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "HYTHttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "HYTHttpFile.h"

static AFNetworkReachabilityStatus _lastNetworkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
static MBProgressHUD *_showProgress = nil;

@implementation HYTHttpTool

+ (void)initialize {
    
    //1.加载指示器
    _showProgress = [[MBProgressHUD alloc] init]; {
        _showProgress.labelText = @"努力加载中...";
        _showProgress.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
        _showProgress.removeFromSuperViewOnHide = YES;
    }
    
    //2.加载网络监听器
    AFNetworkReachabilityManager *networkMgr = [AFNetworkReachabilityManager sharedManager];
    [networkMgr startMonitoring];
    [networkMgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _lastNetworkStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable: {
                _lastNetworkStatus = AFNetworkReachabilityStatusNotReachable;
                [HYTAlertView showAlertMsg:@"抱歉您似乎和网络已断开连接"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                _lastNetworkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                [HYTAlertView showAlertMsg:@"网络以切花至蜂窝网络"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                _lastNetworkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                [HYTAlertView showAlertMsg:@"网络以切花至WiFI"];
                break;
            }
        }
        NSLog(@"setReachabilityStatusChangeBlock");

    }];
}

#pragma mark - GET请求
+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self get:url parameters:parameters autoShowLoading:NO success:success failure:failure];
}
+ (void)get:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [HYTAlertView showAlertMsg:@"抱歉您似乎和网络已断开连接"];
        return;
    }
    
    if (showLoading) { [_showProgress show:YES]; }
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (showLoading) { [_showProgress hide:YES]; }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (showLoading) { [_showProgress hide:YES]; }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - POST请求
+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self post:url parameters:parameters autoShowLoading:NO success:success failure:failure];
}
+ (void)post:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [HYTAlertView showAlertMsg:@"抱歉您似乎和网络已断开连接"];
        return;
    }
    
    if (showLoading) { [_showProgress show:YES]; }
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (showLoading) { [_showProgress hide:YES]; }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (showLoading) { [_showProgress hide:YES]; }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 上传（POST方式）
+ (void)post:(NSString *)url parameters:(id)parameters uploadFiles:(NSArray <HYTHttpFile *> * )files success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self post:url parameters:parameters uploadFiles:files uploadProgressBlock:nil success:success failure:failure];
}
+ (void)post:(NSString *)url parameters:(id)parameters uploadFiles:(NSArray <HYTHttpFile *> *)files uploadProgressBlock:(void (^)(NSUInteger, long long, long long))uploadProgress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *reqOpt = [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [files enumerateObjectsUsingBlock:^(HYTHttpFile * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj.fileData name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
        }];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //加载文件上传进度
    if (uploadProgress) {
        [reqOpt setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            uploadProgress(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }];
    }
}

@end
