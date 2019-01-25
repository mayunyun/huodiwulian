//
//  TiBanSJViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "TiBanSJViewController.h"
#import "JohnTopTitleView.h"
#import "SijiXXViewController.h"
#import "ZhaopinXXViewController.h"
#import "TiBanSJMeViewController.h"

@interface TiBanSJViewController ()
@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation TiBanSJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"替班司机";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"我的"] style:UIBarButtonItemStylePlain target:self action:@selector(rightToLastViewController)];
    [self.navigationItem.rightBarButtonItem setTintColor:MYColor];
    
    [self createUI];
}
- (void)createUI{
    NSArray *titleArray = [NSArray arrayWithObjects:@"司机信息",@"招聘信息", nil];
    self.titleView.title = titleArray;
    //    self.titleView.titleSegment.selectedSegmentIndex = 0;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
    [_titleView setIndexPageBlock:^(NSInteger index) {
        
    }];
}
- (NSArray <UIViewController *>*)setChildVC{
    SijiXXViewController * vc1 = [[SijiXXViewController alloc]init];
    //    [vc1 setHidenSegmentBlock:^(NSInteger index) {
    //
    //    }];
    ZhaopinXXViewController *vc2 = [[ZhaopinXXViewController alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:vc1,vc2, nil];
    return childVC;
}
#pragma mark - getter
- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        if (statusbarHeight>20) {
            _titleView.frame = CGRectMake(0, 88, UIScreenW, UIScreenH-88);
        }
    }
    return _titleView;
}
-(void)rightToLastViewController{
    TiBanSJMeViewController *me = [[TiBanSJMeViewController alloc]init];
    [self.navigationController pushViewController:me animated:YES];
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
