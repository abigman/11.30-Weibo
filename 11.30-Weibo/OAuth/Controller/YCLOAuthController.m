//
//  YCLOAuthController.m
//  11.30-Weibo
//
//  Created by Chenglin Yu on 14/12/9.
//  Copyright (c) 2014年 yclzone. All rights reserved.
//

#import "YCLOAuthController.h"
#import "AFNetworking.h"
//#import "YCLMainTabBarController.h"
//#import "YCLNewfeatureController.h"
#import "YCLControllerTools.h"
#import "YCLAccount.h"
#import "YCLAccountTool.h"

// 应用相关
#define kAppKey             @"1223967393"
#define kRedirect_uri       @"http://yclzone.github.io"
#define kAppSecret          @"948d5ba9945b0ce55347b659e7e7c5af"

// api相关
#define kAuthorize_url      @"https://api.weibo.com/oauth2/authorize"
#define kAccessToken_url    @"https://api.weibo.com/oauth2/access_token"


@interface YCLOAuthController () <UIWebViewDelegate>

@end

@implementation YCLOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *oAuthWebView = [[UIWebView alloc] init];
    oAuthWebView.frame = self.view.frame;
    oAuthWebView.delegate = self;
    [self.view addSubview:oAuthWebView];
    
    // 创建授权请求的 URL
    NSURL *oAuthURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", kAuthorize_url, kAppKey, kRedirect_uri]];
    // 创建授权请求
    NSURLRequest *oAuthRequest = [NSURLRequest requestWithURL:oAuthURL];
    
    // 发送授权请求
    [oAuthWebView loadRequest:oAuthRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"request = %@", request);
    NSString *requestURLString = request.URL.absoluteString;
    
    NSRange range = [requestURLString rangeOfString:kRedirect_uri];
//    NSLog(@"requestURLString = %@", requestURLString);
//    
//    NSLog(@"range = %@", NSStringFromRange(range));
    
    
    if (range.location == 0) {
        NSString *urlWithoutCode = [kRedirect_uri stringByAppendingString:@"/?code="];
        
        NSRange urlWithoutCodeRange = [requestURLString rangeOfString:urlWithoutCode];
        
        NSRange codeRange = NSMakeRange(urlWithoutCode.length, urlWithoutCodeRange.length + 1);
        
        NSString *code = [requestURLString substringWithRange:codeRange];
        
        NSLog(@"code = %@", code);
        
        [self accessTokenWithAuthorizationCode:code];
        
        return NO;
    }
    
    
    return YES;
}



/**
 URL
 https://api.weibo.com/oauth2/access_token
 HTTP请求方式
 POST
 请求参数
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */


/**
 *  通过 AuthorizationCode 获取 accessToken
 *
 *  @param code AuthorizationCode
 */
- (void)accessTokenWithAuthorizationCode:(NSString *)code {
    
    NSMutableDictionary *paramateters = [NSMutableDictionary dictionary];
    paramateters[@"client_id"] = kAppKey;
    paramateters[@"client_secret"] = kAppSecret;
    paramateters[@"grant_type"] = @"authorization_code";
    paramateters[@"code"] = code;
    paramateters[@"redirect_uri"] = kRedirect_uri;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kAccessToken_url parameters:paramateters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 请求成功
        NSLog(@"成功 --- %@", responseObject);
        // 账号信息
        YCLAccount *account = [YCLAccount accountWithDictionary:responseObject];
        NSLog(@"access_token = %@", account.access_token);
        
        // 保存授权信息
        [YCLAccountTool saveAccount:account];
        
        /* 判断是否展示新特性 */
        [YCLControllerTools choseController];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求失败
        NSLog(@"失败 --- %@", error);
        
    }];
}

@end
