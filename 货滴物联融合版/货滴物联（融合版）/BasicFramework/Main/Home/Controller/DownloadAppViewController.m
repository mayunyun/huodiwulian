//
//  DownloadAppViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/9/11.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "DownloadAppViewController.h"

@interface DownloadAppViewController ()

@end

@implementation DownloadAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hd_logo"]];
    titleImageView.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleImageView;
    [self setAboutWXView];
}
-(void)setAboutWXView{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, kScreenWidth, UIScreenH-statusbarHeight-44)];
    
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    UIImageView* headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180*MYWIDTH)];
    headerView.image = [UIImage imageNamed:@"banner2"];
    [bgview addSubview:headerView];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"download_app"]];
    image.frame = CGRectMake(kScreenWidth/2-80*MYWIDTH, headerView.bottom+30*MYWIDTH, 160*MYWIDTH, 160*MYWIDTH);
    [bgview addSubview:image];
    
    UILabel *other = [[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom, kScreenWidth, 40*MYWIDTH)];
    other.textAlignment = NSTextAlignmentCenter;
    other.numberOfLines = 4;
    other.text = @"扫描下载货滴APP";
    other.font = [UIFont systemFontOfSize:14];
    other.textColor = [UIColor blackColor];
    [bgview addSubview:other];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake((kScreenWidth - 100)/2, other.bottom, 100, 30);
    [btn setTitle:@"APP下载" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn];
    
    UIView* grayView = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.height - 130*MYWIDTH, kScreenWidth, 130*MYWIDTH)];
    grayView.backgroundColor = UIColorFromRGB(0xC4C4C4);
    [bgview addSubview:grayView];
    UILabel* detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10*MYWIDTH, kScreenWidth, grayView.height -30*MYWIDTH)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.text = @"山东货滴物联网技术有限公司\n Copyright 2018.All Rights Reserved鲁ICP备\n 18006638号\n 地址：山东省德州市平原县经济开发区南园路\n 侯经理：13953481675\n 电话：0531-88807916";
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.numberOfLines = 0;
    detailLabel.adjustsFontSizeToFitWidth = YES;
    [grayView addSubview:detailLabel];
    
}
- (void)btnClick:(UIButton*) sender{
    NSString *openURL = @"http://m.huodiwulian.com/index.html";
    NSURL *URL = [NSURL URLWithString:openURL];
    
    /**
     ios 9 之前使用
     openURL:打开的网址
     **/
    [[UIApplication sharedApplication]openURL:URL];
    
    
    /**
     ios 10 以后使用  openURL: options: completionHandler:
     这个函数异步执行，但在主队列中调用 completionHandler 中的回调
     openURL:打开的网址
     options:用来校验url和applicationConfigure是否配置正确，是否可用。
     唯一可用@{UIApplicationOpenURLOptionUniversalLinksOnly:@YES}。
     不需要不能置nil，需@{}为置空。
     ompletionHandler:如不需要可置nil
     **/
    [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:^(BOOL success) {
        
    }];
    
    
    
}


@end
