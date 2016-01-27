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
#import "HYTHttpUpload.h"

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

+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self get:url parameters:parameters autoShowLoading:YES success:success failure:failure];
}

+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self post:url parameters:parameters autoShowLoading:YES success:success failure:failure];
}

+ (void)get:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [HYTAlertView showAlertMsg:@"抱歉您似乎和网络已断开连接"];
        return;
    }
    
    if (showLoading) {
        [_showProgress show:YES];
    }
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (showLoading) {
            [_showProgress hide:YES];
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (showLoading) {
            [_showProgress hide:YES];
        }
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [HYTAlertView showAlertMsg:@"抱歉您似乎和网络已断开连接"];
        return;
    }
    
    if (showLoading) {
        [_showProgress show:YES];
    }
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (showLoading) {
            [_showProgress hide:YES];
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (showLoading) {
            [_showProgress hide:YES];
        }
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url parameters:(id)parameters files:(NSArray <HYTHttpUpload *> * )files success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *request = [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [files enumerateObjectsUsingBlock:^(HYTHttpUpload * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
    [request setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"%ld, %lld, %lld",bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
}

@end
