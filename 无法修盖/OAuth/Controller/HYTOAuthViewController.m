//
//  HYTOAuthViewController.m
//  无法修盖
//
//  Created by HelloWorld on 15/10/27.
//  Copyright (c) 2015年 SearchPrefect. All rights reserved.
//

#import "HYTOAuthViewController.h"
//#import "AFNetworking.h"

@interface HYTOAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *sinaOAuthView;

@end

@implementation HYTOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     https://api.weibo.com/oauth2/authorize
     App Key：
     3718372838
     
     App Secret：
     8ebd1ff6d8a3380b747c6fe8907755f6
     */
    UIWebView *sinaOAuthView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    sinaOAuthView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3718372838&redirect_uri=http://m.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [sinaOAuthView loadRequest:request];
    
    
    [self.view addSubview:sinaOAuthView];
    self.sinaOAuthView = sinaOAuthView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    MBLog(@"%@", NSStringFromSelector(_cmd));
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestURLString = request.URL.absoluteString;
    NSRange codeRange = [requestURLString rangeOfString:@"?code="];
    if (codeRange.length>0) {
        NSString *codeValue = [requestURLString substringFromIndex:codeRange.location+codeRange.length];
        
        [self accessTokenWithCode:codeValue];
        return NO;
    }
    
    return YES;
}

//使用授权过的Request Token来请求获得Access Token（访问标记）
- (void)accessTokenWithCode:(NSString *)code {
    
    /**
     https://api.weibo.com/oauth2/access_token
     
     必选 	类型及范围 	说明
     client_id 	true 	string 	申请应用时分配的AppKey。
     client_secret 	true 	string 	申请应用时分配的AppSecret。
     grant_type 	true 	string 	请求的类型，填写authorization_code
     
     
     grant_type为authorization_code时
     
     必选 	类型及范围 	说明
     code 	true 	string 	调用authorize获得的code值。
     redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
     */
    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"client_id"] = @"3718372838";
//    parameters[@"client_secret"] = @"8ebd1ff6d8a3380b747c6fe8907755f6";
//    parameters[@"grant_type"] = @"authorization_code";
//    parameters[@"code"] = code;
//    parameters[@"redirect_uri"] = @"http://m.baidu.com/";
//    
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    [manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^void(AFHTTPRequestOperation * __nonnull a, id __nonnull b) {
//        
//    } failure:^void(AFHTTPRequestOperation * __nullable c , NSError * __nonnull d) {
//        
//    }];

    
}

@end
