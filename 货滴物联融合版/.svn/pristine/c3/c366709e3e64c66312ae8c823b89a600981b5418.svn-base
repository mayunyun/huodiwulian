//
//  CarshopViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/9/12.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "CarshopViewController.h"
#import "ErSCshopViewController.h"
#import "MyErSCViewController.h"
@interface CarshopViewController ()

@end

@implementation CarshopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 25)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 25)];
    titleLab.text = @"货滴车市";
    titleLab.textColor = [UIColor redColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    
    self.navigationItem.titleView = titleView;
    
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(UIScreenW - 70, 10, 50, 40);
    [button setTitle:@"我的" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addNext) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    [self creatUI];
}
- (void)creatUI{
    UIScrollView* bgsView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, kScreenWidth, kScreenHeight-statusbarHeight-44)];
    bgsView.contentSize = CGSizeMake(kScreenWidth, 650*MYWIDTH);
    bgsView.showsVerticalScrollIndicator = NO;
    bgsView.showsHorizontalScrollIndicator = NO;
    bgsView.bounces = NO;
    bgsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgsView];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, 0, UIScreenW-30*MYWIDTH, 150*MYWIDTH)];
    imageview.image = [UIImage imageNamed:@"二手车one"];
    imageview.userInteractionEnabled = YES;
    [bgsView addSubview:imageview];
    
    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap1.cancelsTouchesInView = NO;
    [imageview addGestureRecognizer:tap1];
    
    NSArray *arr1 = @[@"准新车",@"全新厢货",@"可签全国"];
    NSArray *arr2 = @[@"新车二手价",@"首付0元起",@"过户无障碍"];
    NSArray *arr3 = @[@"图层3",@"图层411",@"过户"];
    float width = (UIScreenW-34*MYWIDTH)/3;
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH+i*width+i*2*MYWIDTH, imageview.bottom+10*MYWIDTH, width, 150*MYWIDTH)];
        view.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [bgsView addSubview:view];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 30*MYWIDTH)];
        lab.text = arr1[i];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:14*MYWIDTH];
        [view addSubview:lab];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*MYWIDTH, width, 20*MYWIDTH)];
        lab1.text = arr2[i];
        lab1.textColor = UIColorFromRGB(0xff5400);
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = [UIFont systemFontOfSize:12*MYWIDTH];
        [view addSubview:lab1];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10*MYWIDTH, lab1.bottom+25*MYWIDTH, width-20*MYWIDTH, 150*MYWIDTH-30*MYWIDTH-lab1.bottom)];
        image.image = [UIImage imageNamed:arr3[i]];
        [view addSubview:image];
    }
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, imageview.bottom+170*MYWIDTH, UIScreenW-30*MYWIDTH, 150*MYWIDTH)];
    imageview1.image = [UIImage imageNamed:@"新车"];
    imageview1.userInteractionEnabled = YES;
    [bgsView addSubview:imageview1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped1)];
    tap2.cancelsTouchesInView = NO;
    [imageview1 addGestureRecognizer:tap2];
    
    NSArray *arr4 = @[@"新车上架",@"省油爆款",@"新能源专场"];
    NSArray *arr5 = @[@"智能出行上新车",@"全网省油TOP10",@"大波电动来袭"];
    NSArray *arr6 = @[@"新车上架",@"云内DEV系列",@"新能源专场"];
    
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH+i*width+i*2*MYWIDTH, imageview1.bottom+10*MYWIDTH, width, 150*MYWIDTH)];
        view.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [bgsView addSubview:view];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 30*MYWIDTH)];
        lab.text = arr4[i];
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:14*MYWIDTH];
        [view addSubview:lab];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*MYWIDTH, width, 20*MYWIDTH)];
        lab1.text = arr5[i];
        lab1.textColor = UIColorFromRGB(0x666666);
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = [UIFont systemFontOfSize:12*MYWIDTH];
        [view addSubview:lab1];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10*MYWIDTH, lab1.bottom+25*MYWIDTH, width-20*MYWIDTH, 150*MYWIDTH-30*MYWIDTH-lab1.bottom)];
        image.image = [UIImage imageNamed:arr6[i]];
        [view addSubview:image];
    }
    
}
- (void)viewTapped{
    ErSCshopViewController *HuodongVC = [[ErSCshopViewController alloc]init];
    HuodongVC.type = @"1";
    HuodongVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HuodongVC animated:YES];
}
- (void)viewTapped1{
    ErSCshopViewController *HuodongVC = [[ErSCshopViewController alloc]init];
    HuodongVC.type = @"2";
    HuodongVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HuodongVC animated:YES];
}
- (void)addNext{
    [Command isloginRequest:^(bool str) {
        if (str) {
            MyErSCViewController *myersh = [[MyErSCViewController alloc]init];
            
            [self.navigationController pushViewController:myersh animated:YES];
        }else{
            jxt_showAlertTwoButton(@"您目前还没有登录", @"是否前往登录", @"取消", ^(NSInteger buttonIndex) {
                
            }, @"前往", ^(NSInteger buttonIndex) {
                LoginVC* vc = [[LoginVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            });
        }
    }];
    
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
