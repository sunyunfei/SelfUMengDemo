//
//  AppDelegate.m
//  SelfUMengDemo
//
//  Created by 孙云 on 15/10/26.
//  Copyright © 2015年 haidai. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //加载窗口
    self.window=[[UIWindow alloc]initWithFrame:
                                            [UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //加载控制器
    ShareViewController *share = [[ShareViewController alloc]
                                                            init];
    share.title = @"分享自定义";
    UINavigationController *navShare = [[UINavigationController alloc]
                                        initWithRootViewController:share];
    navShare.navigationBar.barTintColor = [UIColor
                                           colorWithRed:239 * 1.0 /255
                                           green:249 * 1.0 /255
                                           blue:245 * 1.0 /255
                                           alpha:1.0f];
    self.window.rootViewController = navShare;

#pragma mark------注册友盟社会化分享
    //设置友盟分享的AppKey
    [UMSocialData setAppKey:@"562dc23ce0f55ac87b00057e"];
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关
    //    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //打开腾讯微博SSO开关，设置回调地址，只支持32位
    //    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    return YES;
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}
@end
