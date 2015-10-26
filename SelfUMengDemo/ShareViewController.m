//
//  ViewController.m
//  SelfUMengDemo
//
//  Created by 孙云 on 15/10/26.
//  Copyright © 2015年 haidai. All rights reserved.
//

#import "ShareViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface ShareViewController ()
//阴影视图
@property(nonatomic,weak)UIView *shadowView;
//分享视图
@property(nonatomic,weak)UIView *ShareView;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定义一个分享按钮
    [self loadShareBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建视图
-(void)loadAllView
{
    //创建阴影视图
    UIView *shadowView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    shadowView.backgroundColor = [UIColor lightGrayColor];
    shadowView.alpha = 0.0f;
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController.view addSubview:shadowView];
    self.shadowView = shadowView;
    //创建分享视图
    UIView *shareView = [[UIView alloc]
                         initWithFrame:CGRectMake(40, HEIGHT,WIDTH - 80,200)];
    shareView.layer.cornerRadius = 10;
    shareView.layer.masksToBounds = YES;
    shareView.backgroundColor = [UIColor
                                 colorWithRed:199 * 1.0 /255
                                 green:237 * 1.0 /255
                                 blue:204 * 1.0 /255
                                 alpha:1.0f];
    [app.window.rootViewController.view addSubview:shareView];
    self.ShareView = shareView;
    
    //分享视图上加载按钮
    NSArray *nameArray = @[@"博",@"信",@"Q",@"空"];
    for(int i = 0;i < 4;i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * self.ShareView.frame.size.width/4, 50, self.ShareView.frame.size.width/4, self.ShareView.frame.size.width/4);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:30];
        btn.layer.cornerRadius = btn.frame.size.width /2;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor
                               colorWithRed:300 * 1.0 /255
                               green:200 * 1.0 /255
                               blue:100 * 1.0 /255
                               alpha:1.0f];
        [btn setTitle:nameArray[i]
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(clickShare:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.ShareView addSubview:btn];
    }
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 150, self.ShareView.frame.size.width, 50);
    [cancelBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(cancelChoose)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.ShareView addSubview:cancelBtn];
}
//分享按钮
-(void)loadShareBtn
{
    UIButton *shareBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    shareBtn.frame = CGRectMake((WIDTH - 80)/2,(HEIGHT - 80)/2, 80, 80);
    //美化
    shareBtn.backgroundColor = [UIColor
                                colorWithRed:240 * 1.0 /255
                                green:230 * 1.0 /255
                                blue:200 * 1.0 /255
                                alpha:1.0f];
    shareBtn.layer.borderWidth = 10;
    shareBtn.layer.borderColor = [UIColor
                                    colorWithRed:239 * 1.0 /255
                                    green:249 * 1.0 /255
                                    blue:245 * 1.0 /255
                                    alpha:0.5f].CGColor;
    shareBtn.layer.cornerRadius = shareBtn.frame.size.width / 2;
    shareBtn.layer.masksToBounds = YES;
    [shareBtn addTarget:self
                 action:@selector(showView)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}
//按钮事件
-(void)showView
{
    [self loadAllView];
    //动画加载
    [UIView animateWithDuration:0.5 animations:
     ^{
         self.shadowView.alpha = 0.5f;
         CGRect rect = self.ShareView.frame;
         rect.origin.y = (HEIGHT - 200)/2;
         self.ShareView.frame = rect;

     }
                     completion:^(BOOL finish)
    {
        
    }];
}
//分享按钮点击事件
-(void)clickShare:(UIButton *)sender
{
    UIImage *shareImage = [UIImage imageNamed:@"share.jpg"];
    switch (sender.tag) {
        case 0:
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"友盟自定义布局分享";
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
        case 1:
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"友盟自定义布局分享";
            //UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"我叫孙云飞" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
        case 2:
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"我叫孙云飞" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
        case 3:
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"友盟自定义布局分享";
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"我叫孙云飞" image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            break;
        default:
            break;
    }
}
//点击取消按钮
-(void)cancelChoose
{
    //动画取消
    [UIView animateWithDuration:0.5 animations:
     ^{
         self.shadowView.alpha = 0.0f;
         CGRect rect = self.ShareView.frame;
         rect.origin.y = HEIGHT ;
         self.ShareView.frame = rect;
         
     }
                     completion:^(BOOL finish)
     {
         [self.ShareView removeFromSuperview];
         self.ShareView = nil;
     }];

}
@end
