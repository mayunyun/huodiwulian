//
//  SijiDingDViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "SijiDingDViewController.h"
#import "SijiDingDetailsViewController.h"

#import "ZhaopinModel.h"
#import "SijiDingDTableViewCell.h"

@interface SijiDingDViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation SijiDingDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"司机订单";
    
    _dataArr = [[NSMutableArray alloc]init];
    
    [self loadNewSearchSuyunorder];
    [self tableview];
}
- (void)loadNewSearchSuyunorder
{
    [_dataArr removeAllObjects];
    NSString *URLStr = @"/mbtwz/driverrecruit?action=selectDriverOrderList";
    
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",array);
        if (!IsEmptyValue(array)) {
            for (NSDictionary*dic in array) {
                ZhaopinModel *model=[[ZhaopinModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                //追加数据
                [_dataArr addObject:model];
            }
        }
        [_tableview reloadData];
        
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 225;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * stringCell = @"SijiDingDTableViewCell";
    SijiDingDTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count) {
        ZhaopinModel *model = _dataArr[indexPath.row];
        cell.province.text = [NSString stringWithFormat:@"%@%@——%@%@",model.sprovince,model.scity,model.eprovince,model.ecity];
        
        cell.name.text = [NSString stringWithFormat:@"联系人：%@",model.name];
        cell.phone.text = [NSString stringWithFormat:@"联系电话：%@",model.phone];
        cell.stime.text = [NSString stringWithFormat:@"出车时间：%@",model.stime];
        cell.etime.text = [NSString stringWithFormat:@"结束时间：%@",model.etime];
        cell.price.text = [NSString stringWithFormat:@"司机报酬：%@/人",model.price];

        if ([model.status intValue]==5) {
            cell.status.text = @"接单成功";
        }else if ([model.status intValue]==4){
            cell.status.text = @"接单失败";
        }else if ([model.status intValue]==3){
            cell.status.text = @"已结束";
        }else if ([model.status intValue]==2){
            cell.status.text = @"待付款";
        }else if ([model.status intValue]==1){
            cell.status.text = @"进行中";
        }else if ([model.status intValue]==0){
            cell.status.text = @"等待确认";
        }
        else{
            cell.status.text = @"";
        }
        cell.button.tag = indexPath.row;
        [cell.button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}
- (void)butClick:(UIButton *)but{
    ZhaopinModel *model = _dataArr[but.tag];
    SijiDingDetailsViewController *details = [[SijiDingDetailsViewController alloc]init];
    details.id = model.id;
    [self.navigationController pushViewController:details animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.view addSubview:_tableview];
        
    }
    return _tableview;
    
}
- (void)loadNewData{
    
    [self loadNewSearchSuyunorder];
    
    [_tableview.mj_header endRefreshing];
    
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
