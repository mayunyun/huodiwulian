//
//  MyErSCViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/7/20.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "MyErSCViewController1.h"
#import "mainCollectionViewCell1.h"
#import "MyErSCshopViewController1.h"
#import "FaBuErSCViewController1.h"

@interface MyErSCViewController1 ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UICollectionView *IconsCollectionView;

@end

@implementation MyErSCViewController1


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    titleLab.text = @"我的";
    titleLab.textColor = [UIColor redColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    self.navigationItem.titleView = titleView;
    [self IconsCollectionView];
    
}
- (UICollectionView *)IconsCollectionView{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;//行间距
    flowLayout.minimumLineSpacing = 10;//列间距
    if (_IconsCollectionView == nil) {
        _IconsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight) collectionViewLayout:flowLayout];
        //隐藏滑块
        _IconsCollectionView.showsVerticalScrollIndicator = NO;
        _IconsCollectionView.showsHorizontalScrollIndicator = NO;
        
        _IconsCollectionView.backgroundColor = UIColorFromRGB(0xEFEFEF);
        _IconsCollectionView.dataSource = self;
        _IconsCollectionView.delegate = self;
        //注册单元格
        [_IconsCollectionView registerNib:[UINib nibWithNibName:@"mainCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"mainCollectionViewCell1"];
        [_IconsCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];  //  一定要设置
        
        [self.view addSubview:_IconsCollectionView];
    }
    return _IconsCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return 8;
    return 4;
}
//调整Item的位置 使Item不紧挨着屏幕
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //在原有基础上进行调整 上 左 下 右
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(UIScreenW/2-20, (UIScreenW/2-20)*20/32);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HomeSelarCellID = @"mainCollectionViewCell1";
    
    //在这里注册自定义的XIBcell 否则会提示找不到标示符指定的cell
    UINib *nib = [UINib nibWithNibName:@"mainCollectionViewCell1" bundle: [NSBundle mainBundle]];
    [_IconsCollectionView registerNib:nib forCellWithReuseIdentifier:HomeSelarCellID];
    
    mainCollectionViewCell1*cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeSelarCellID forIndexPath:indexPath];
    NSArray *imageArr = @[@"我发布的二手车",@"我发布的新车",@"发布二手车",@"发布新车"];
    NSArray *nameArr = @[@"",@"",@"",@""];
    [cell setdataimage:imageArr[indexPath.row] title:nameArr[indexPath.row]];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MyErSCshopViewController1 *MyYuE = [[MyErSCshopViewController1 alloc]init];
        MyYuE.type = @"0";
        [self.navigationController pushViewController:MyYuE animated:YES];
    }
    else if (indexPath.row == 1){
        MyErSCshopViewController1 *MyYuE = [[MyErSCshopViewController1 alloc]init];
        MyYuE.type = @"1";
        [self.navigationController pushViewController:MyYuE animated:YES];
    }
    else if (indexPath.row == 2){
        
        FaBuErSCViewController1 *MyYuE = [[FaBuErSCViewController1 alloc]init];
        MyYuE.type = @"0";
        [self.navigationController pushViewController:MyYuE animated:YES];
    }else if (indexPath.row == 3){
        
        FaBuErSCViewController1 *MyYuE = [[FaBuErSCViewController1 alloc]init];
        MyYuE.type = @"1";
        [self.navigationController pushViewController:MyYuE animated:YES];
    }
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
