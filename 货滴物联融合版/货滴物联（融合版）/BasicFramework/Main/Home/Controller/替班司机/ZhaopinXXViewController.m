//
//  ZhaopinXXViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "ZhaopinXXViewController.h"
#import "SijiDingDViewController.h"

#import "ZhaopinModel.h"
#import "ZhaopinXXTableViewCell.h"

@interface ZhaopinXXViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation ZhaopinXXViewController

{
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    [self loadNewSearchSuyunorder];
    [self tableview];
}
- (void)loadNewSearchSuyunorder
{
    if (_page==1) {
        [_dataArr removeAllObjects];
    }
    NSString *URLStr = @"/mbtwz/driverrecruit?action=selectDriverRecruitList";
    NSDictionary* params = @{@"page":[NSString stringWithFormat:@"%li",(long)_page],@"rows":@"8"};
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"rows"];
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
    
    return 245;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * stringCell = @"ZhaopinXXTableViewCell";
    ZhaopinXXTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count) {
        ZhaopinModel *model = _dataArr[indexPath.row];
        cell.province.text = [NSString stringWithFormat:@"%@%@——%@%@",model.sprovince,model.scity,model.eprovince,model.ecity];

        cell.name.text = [NSString stringWithFormat:@"联系人：%@",model.name];
        cell.phone.text = [NSString stringWithFormat:@"联系电话：%@",model.phone];
        cell.neednum.text = [NSString stringWithFormat:@"需要司机人数：%@人",model.neednum];
        cell.stime.text = [NSString stringWithFormat:@"出车时间：%@",model.stime];
        cell.etime.text = [NSString stringWithFormat:@"结束时间：%@",model.etime];
        cell.price.text = [NSString stringWithFormat:@"司机报酬：%@/人",model.price];
        [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.button.tag = indexPath.row;
        [cell.button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}
- (void)butClick:(UIButton *)but{
    jxt_showAlertTwoButton(@"提示", @"您确认接受招聘吗？", @"取消", ^(NSInteger buttonIndex) {
        
    }, @"确定", ^(NSInteger buttonIndex) {
        
        ZhaopinModel *model = _dataArr[but.tag];
        
        NSString *XWURLStr = @"/mbtwz/driverrecruit?action=selectDrivRecRobbing";
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:[NSString stringWithFormat:@"%@",model.id] forKey:@"orderid"];
        
        
        NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:XWURLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==200) {
                jxt_showAlertOneButton(@"提示", @"接单成功", @"确定", ^(NSInteger buttonIndex) {
                    SijiDingDViewController *dingdan = [[SijiDingDViewController alloc]init];
                    [self.navigationController pushViewController:dingdan animated:YES];
                });
            }else{
                
                jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
                });
            }
        }];
    });
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH-64-40)];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 0, UIScreenW, UIScreenH-88-40);
            
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addnewData)];
        
    }
    return _tableview;
    
}
- (void)loadNewData{
    _page=1;
    [self loadNewSearchSuyunorder];
    
    [_tableview.mj_header endRefreshing];
    
}
- (void)addnewData{
    _page ++;
    [self loadNewSearchSuyunorder];
    [_tableview.mj_footer endRefreshing];
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
