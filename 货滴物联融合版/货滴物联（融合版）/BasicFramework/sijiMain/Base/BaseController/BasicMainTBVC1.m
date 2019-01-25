//
//  BasicMainTBVC1.m
//  BasicFramework
//
//  Created by Rainy on 2017/1/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kHomePageVC_IMG @"home_normal"
#define kHomePageVC_Selected_IMG @"home_highlight"
#define kHomePageVC_Title @"首页"
#define kShopPageVC1_IMG @"shop_normal"
#define kShopPageVC1_Selected_IMG @"shop_highlight"
#define kShopPageVC1_Title @"订单"
#define kFindPageVC1_IMG @"find_normal"
#define kFindPageVC1_Selected_IMG @"find_highlight"
#define kFindPageVC1_Title @"社区"
#define kMinePageVC1_IMG @"mine_normal"
#define kMinePageVC1_Selected_IMG @"mine_highlight"
#define kMinePageVC1_Title @"我的"
#import "BasicMainTBVC1.h"
#import "NewHomePageVC1.h"
#import "ShopPageVC1.h"
#import "FindPageVC1.h"
#import "MinePageVC1.h"
#import "BasicMainNC1.h"
#import "BaseTabBar1.h"
#import "HomeSuYunVC1.h"
@interface BasicMainTBVC1 ()

@end

@implementation BasicMainTBVC1
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = kNormalFontColor;
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = ThemeColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllers];
    
#pragma mark - 自定义tabbar
    BaseTabBar1 *tabbar = [[BaseTabBar1 alloc] init];
    //tabbar.myDelegate = self;
    //修改系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
//    [self.tabBar setBackgroundImage:[UIImage new]];
//    [self.tabBar setShadowImage:[UIImage new]];
    
}

- (void)addChildViewControllers
{
    NewHomePageVC1 *HomeVC = [[NewHomePageVC1 alloc] init];
    [self setChildViewController:HomeVC Image:kHomePageVC_Selected_IMG selectedImage:kHomePageVC_Selected_IMG title:kHomePageVC_Title];
    ShopPageVC1 *ShopVC = [[ShopPageVC1 alloc] init];
    [self setChildViewController:ShopVC Image:kShopPageVC1_Selected_IMG selectedImage:kShopPageVC1_Selected_IMG title:kShopPageVC1_Title];
    FindPageVC1 *FindVC = [[FindPageVC1 alloc] init];
    [self setChildViewController:FindVC Image:kFindPageVC1_Selected_IMG selectedImage:kFindPageVC1_Selected_IMG title:kFindPageVC1_Title];
    MinePageVC1 *MineVC = [[MinePageVC1 alloc] init];
    [self setChildViewController:MineVC Image:kMinePageVC1_Selected_IMG selectedImage:kMinePageVC1_Selected_IMG title:kMinePageVC1_Title];
    
}

#pragma mark - 初始化设置ChildViewControllers
/**
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setChildViewController:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    BasicMainNC1 *NA_VC = [[BasicMainNC1 alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.title = title;
    
    [self addChildViewController:NA_VC];
    
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
