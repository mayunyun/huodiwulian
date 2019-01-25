//
//  PinpaiSousuoViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/10/12.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "PinpaiSousuoViewController1.h"
#import "CarHomeHeadView1.h"
#import "CarHoMeTableViewCell1.h"

@interface PinpaiSousuoViewController1 ()<UITableViewDataSource,UITableViewDelegate,CarHomeHeadView1Delegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)CarHomeHeadView1 *CarHomeHeadView1;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@end

@implementation PinpaiSousuoViewController1

- (UITableView *)tableview{
    if (_tableview == nil) {
        
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight-88);
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        _CarHomeHeadView1 = [[CarHomeHeadView1 alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 260*MYWIDTH)];
        _CarHomeHeadView1.delegate = self;
        
        UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, _CarHomeHeadView1.bottom-50*MYWIDTH, kScreenWidth, 50*MYWIDTH)];
        bgview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [_CarHomeHeadView1 addSubview:bgview];
        
        UIButton *buxianbut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*MYWIDTH)];
        buxianbut.backgroundColor = [UIColor whiteColor];
        [buxianbut setTitle:@"   ※ 不限品牌" forState:UIControlStateNormal];
        buxianbut.titleLabel.font = [UIFont boldSystemFontOfSize:15*MYWIDTH];
        [buxianbut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        buxianbut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [buxianbut addTarget:self action:@selector(buxianpinpaiClick) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:buxianbut];
        
        _tableview.tableHeaderView = _CarHomeHeadView1;
        
        
        [_tableview registerClass:[CarHoMeTableViewCell1 class] forCellReuseIdentifier:NSStringFromClass([CarHoMeTableViewCell1 class])];
        
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _tableview;
    
}
- (void)buxianpinpaiClick{
    if (_pinpaiNameBlock) {
        _pinpaiNameBlock(@"");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//下拉刷新
- (void)loadNewData{
    [self loadNew];
    [self headviewlodaData];
    [_tableview.mj_header endRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    
    
    self.navigationItem.title = @"品牌搜索";
    [self headviewlodaData];
    [self loadNew];
    [self tableview];
    
}

- (void)loadNew{
    NSString *URLStr = @"/mbtwz/secondhandcar?action=selectPubSechancarBrand";
    
    [_dataArr removeAllObjects];
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            NSArray *Arr = [[NSArray alloc]initWithArray:[dic objectForKey:@"response"]];
            //NSLog(@"品牌列表%@",Arr);
            if (!IsEmptyValue(Arr)) {
                for (NSDictionary* dict in Arr) {
                    CarBrandModel1* model = [[CarBrandModel1 alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [_dataArr addObject:model];
                }
                //根据Person对象的 name 属性 按中文 对 Person数组 排序
                self.indexArray = [BMChineseSort IndexWithArray:_dataArr Key:@"brandname"];
                self.letterResultArr = [BMChineseSort sortObjectArray:_dataArr Key:@"brandname"];
            }
            if (self.dataArr.count>0) {
                //            [self.tableview dismissNoView];
                [self.tableview reloadData];
                
            }else{
                [self.tableview reloadData];
                //            [self.tableview showNoView:nil image:nil certer:CGPointZero];
            }
        }
        
        
        
        
    }];
}
- (void)headviewlodaData{
    NSString *URLStr = @"/mbtwz/CarHome?action=getCarBrand";
    NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"ishot\":\"%@\"}",@"1"]};
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
        
        NSArray* Arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"热门品牌列表%@",Arr);
        NSMutableArray *data = [[NSMutableArray alloc]init];
        if (!IsEmptyValue(Arr)) {
            if ([Arr count] >5) {
                _CarHomeHeadView1.frame = CGRectMake(0, 0, kScreenWidth, 210*MYWIDTH+50*MYWIDTH);
            }else if ([Arr count]>0){
                _CarHomeHeadView1.frame = CGRectMake(0, 0, kScreenWidth, 132*MYWIDTH+50*MYWIDTH);
            }else{
                _CarHomeHeadView1.frame = CGRectMake(0, 0, kScreenWidth, 50*MYWIDTH);
            }
            
            for (NSDictionary* dict in Arr) {
                CarBrandModel1* model = [[CarBrandModel1 alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [data addObject:model];
            }
        }
        [_CarHomeHeadView1 dataHeadView:data];
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.indexArray.count) {
        return [self.indexArray count];
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.letterResultArr.count) {
        NSArray *arr = [self.letterResultArr objectAtIndex:section];
        return arr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30*MYWIDTH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56*MYWIDTH;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30*MYWIDTH)];
    headview.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30*MYWIDTH)];
    lab.text = [NSString stringWithFormat:@"%@",self.indexArray[section]];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = UIColorFromRGB(0x333333);
    [headview addSubview:lab];
    if (section != 0) {
        UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 0.5)];
        xian.backgroundColor = UIColorFromRGB(MYLine);
        [headview addSubview:xian];
    }
    return headview;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Class HomeClass = [CarHoMeTableViewCell1 class];
    CarHoMeTableViewCell1 *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HomeClass)];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    if (self.letterResultArr.count) {
        //获得对应的Person对象<替换为你自己的model对象>
        CarBrandModel1 *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.data = model;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CarBrandModel1 *model = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (_pinpaiNameBlock) {
        _pinpaiNameBlock(model.brandname);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)CarHomeHeadView1BtnHaveString:(NSString *)brandname idStr:(NSString *)idStr{
    if (_pinpaiNameBlock) {
        _pinpaiNameBlock(brandname);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 40;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}



@end
