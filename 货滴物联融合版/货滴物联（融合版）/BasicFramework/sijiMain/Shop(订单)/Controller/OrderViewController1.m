//
//  OrderViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/2/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "OrderViewController1.h"
#import "TCHXiaoJModel1.h"
#import "TCHBanJModel1.h"
#import "TCHKuaiYModel1.h"

#import "TongChXiaoCell1.h"
#import "TongChBanCell1.h"
#import "KuaiYunTableViewCell1.h"

#import "WuliuOrderDetail11.h"
#import "TongChBanOrderDetail11.h"
#import "TongChKuaiYOrderDetail11.h"

@interface OrderViewController1 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation OrderViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单搜索结果";
    [self tableview];
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_typeStr isEqualToString:@"2"]) {
        return 205*MYWIDTH;
    }
    return 240*MYWIDTH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_typeStr isEqualToString:@"0"]) {
        Class ZuLinCarClass = [TongChXiaoCell1 class];
        TongChXiaoCell1 *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZuLinCarClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor clearColor];
        if (_dataArr.count) {
            NSLog(@"%@",_dataArr);
            TCHXiaoJModel1 *model = _dataArr[indexPath.row];
            [cell setwithDataModel:model];
        }
        return cell;
    }else if ([_typeStr isEqualToString:@"1"]){
        Class ZuLinCarClass = [TongChBanCell1 class];
        TongChBanCell1 *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZuLinCarClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor clearColor];
        if (_dataArr.count) {
            NSLog(@"%@",_dataArr);
            TCHBanJModel1 *model = _dataArr[indexPath.row];
            [cell setwithDataModel:model];
        }
        return cell;
    }
    Class ZuLinCarClass = [KuaiYunTableViewCell1 class];
    KuaiYunTableViewCell1 *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZuLinCarClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor clearColor];
    if (_dataArr.count) {
        NSLog(@"%@",_dataArr);
        TCHKuaiYModel1 *model = _dataArr[indexPath.row];
        [cell setwithDataModel:model];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_typeStr isEqualToString:@"0"]) {
        TCHXiaoJModel1 *model = _dataArr[indexPath.row];
        WuliuOrderDetail11 *detail = [[WuliuOrderDetail11 alloc]init];
        detail.orderno = model.orderno;
        detail.custid = model.owner_custid;
        [self.navigationController pushViewController:detail animated:YES];
    }else if ([_typeStr isEqualToString:@"1"]){
        TCHBanJModel1 *model = _dataArr[indexPath.row];
        TongChBanOrderDetail11 *detail = [[TongChBanOrderDetail11 alloc]init];
        detail.orderno = model.owner_orderno;
        detail.custid = model.owner_custid;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        TCHKuaiYModel1 *model = _dataArr[indexPath.row];
        TongChKuaiYOrderDetail11 *detail = [[TongChKuaiYOrderDetail11 alloc]init];
        detail.orderno = model.orderno;
        detail.custid = model.owner_custid;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 64, UIScreenW, 1)];
        if (statusbarHeight>20) {
            line.frame = CGRectMake(0, 88, UIScreenW, 1);
        }
        line.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [self.view addSubview:line];
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, line.bottom, UIScreenW, UIScreenH-65)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        if ([_typeStr isEqualToString:@"0"]) {
            [_tableview registerClass:[TongChXiaoCell1 class] forCellReuseIdentifier:NSStringFromClass([TongChXiaoCell1 class])];
        }else if ([_typeStr isEqualToString:@"1"]){
            [_tableview registerClass:[TongChBanCell1 class] forCellReuseIdentifier:NSStringFromClass([TongChBanCell1 class])];
        }else{
            [_tableview registerClass:[KuaiYunTableViewCell1 class] forCellReuseIdentifier:NSStringFromClass([KuaiYunTableViewCell1 class])];

        }
    }
    return _tableview;
    
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
