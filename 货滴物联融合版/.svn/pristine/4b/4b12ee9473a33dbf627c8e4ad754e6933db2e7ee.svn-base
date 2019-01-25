//
//  HomeSuYunVC1.m
//  BasicFramework
//
//  Created by LONG on 2018/1/30.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "HomeSuYunVC1.h"
#import "HomeSuYunXiaoJVC1.h"
#import "HomeSuYunBanJVC1.h"
#import "JohnTopTitleView1.h"

@interface HomeSuYunVC1 ()

@property (nonatomic,strong) JohnTopTitleView1 *titleView;

@end

@implementation HomeSuYunVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huodisuyun"]];
    titleImageView.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleImageView;
    
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭

    [self setWithUIview];
    
}

- (void)setWithUIview{
    NSArray *titleArray = [NSArray arrayWithObjects:@"同城小件单",@"同城搬家单", nil];
    self.titleView.title = titleArray;
    //    self.titleView.titleSegment.selectedSegmentIndex = 0;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
   
}
- (NSArray <UIViewController *>*)setChildVC{
    HomeSuYunXiaoJVC1 * vc1 = [[HomeSuYunXiaoJVC1 alloc]init];
    
    HomeSuYunBanJVC1 *vc2 = [[HomeSuYunBanJVC1 alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:vc1,vc2, nil];
    return childVC;
}
#pragma mark - getter
- (JohnTopTitleView1 *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView1 alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        if (statusbarHeight>20) {
            _titleView.frame = CGRectMake(0, 88, UIScreenW, UIScreenH-88);
        }
    }
    return _titleView;
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
