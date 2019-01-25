//
//  TiBanSJMeViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "TiBanSJMeViewController.h"
#import "TiBanFaBuViewController.h"
#import "ZhaopinDingDViewController.h"
#import "SijiDingDViewController.h"

@interface TiBanSJMeViewController ()

@end

@implementation TiBanSJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = UIColorFromRGB(0xEEEEEE);

    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, statusbarHeight+44)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH, statusbarHeight+44+20*MYWIDTH, UIScreenW-30*MYWIDTH, 150*MYWIDTH)];
    [but setBackgroundImage:[UIImage imageNamed:@"fbzp"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH, but.bottom+20*MYWIDTH, (UIScreenW-40*MYWIDTH)/2, 140*MYWIDTH)];
    [but1 setBackgroundImage:[UIImage imageNamed:@"我的招聘"] forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(ZhaopinbutClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:but1];
    
    UIButton *but2 = [[UIButton alloc]initWithFrame:CGRectMake(but1.right+10*MYWIDTH, but1.top, but1.width, 140*MYWIDTH)];
    [but2 setBackgroundImage:[UIImage imageNamed:@"wssj"] forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(SijibutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
}
- (void)butClick{
    TiBanFaBuViewController *fabu = [[TiBanFaBuViewController alloc]init];
    [self.navigationController pushViewController:fabu animated:YES];
}
- (void)ZhaopinbutClick{
    ZhaopinDingDViewController *fabu = [[ZhaopinDingDViewController alloc]init];
    [self.navigationController pushViewController:fabu animated:YES];
}
- (void)SijibutClick{
    SijiDingDViewController *fabu = [[SijiDingDViewController alloc]init];
    [self.navigationController pushViewController:fabu animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
