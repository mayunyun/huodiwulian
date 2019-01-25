//
//  MyLineViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/9/25.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "MyLineViewController1.h"
#import "mylineTableViewCell1.h"
#import "LineFaBuViewController1.h"
#import "MylineModel1.h"
#import "MyLineDetailsViewController1.h"
@interface MyLineViewController1 ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MyLineViewController1
{
    UILabel *_tishiLab;
    UISwitch *_mainSwitch;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self dataRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 25)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 25)];
    titleLab.text = @"我的路线";
    titleLab.textColor = [UIColor redColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"路线发布"] style:UIBarButtonItemStylePlain target:self action:@selector(rightToLastViewController)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor redColor]];
    
    _tishiLab = [[UILabel alloc]initWithFrame:CGRectMake(15*MYWIDTH, statusbarHeight+44, 200*MYWIDTH, 50)];
    _tishiLab.text = @"货源声音提醒（已关闭）";
    _tishiLab.textColor = [UIColor blackColor];
    _tishiLab.font = [UIFont systemFontOfSize:15*MYWIDTH];
    [self.view addSubview:_tishiLab];
    
    _mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(UIScreenW-70, statusbarHeight+54, 0, 0)];
    //_mainSwitch.transform = CGAffineTransformMakeScale(1.5, 1);
    _mainSwitch.backgroundColor = UIColorFromRGB(0xEEEEEE);
    _mainSwitch.onTintColor = [UIColor redColor];
    _mainSwitch.layer.cornerRadius = 15;
    [_mainSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mainSwitch];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self tableview];
    
}
//查询接口
- (void)dataRequest{
    
    [_dataArray removeAllObjects];
    NSString *url = @"/mbtwz/route?action=queryRoute";
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:nil FinishedLogin:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
        NSArray *arr = [[NSArray alloc]initWithArray:[dic[@"response"][0] objectForKey:@"myrote"]];
        int y=0;
        for (NSDictionary* dict in arr) {
            MylineModel1* model = [[MylineModel1 alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
            y = y+[model.remind intValue];
        }
        if (y==arr.count) {
            _mainSwitch.on = YES;
            _tishiLab.text = @"货源声音提醒（已开启）";
        }else{
            _mainSwitch.on = NO;
            _tishiLab.text = @"货源声音提醒（已关闭）";
        }
        [_tableview reloadData];
        
    }];
    
    
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, statusbarHeight+94, kScreenWidth, kScreenHeight-statusbarHeight-94)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        // _tableview.scrollEnabled =NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
    }
    return _tableview;
    
}
- (void)switchAction{
    NSString *route_status;
    if (_mainSwitch.on) {
        NSLog(@"switch is on");
        route_status = @"1";
        _tishiLab.text = @"货源声音提醒（已开启）";
    } else {
        NSLog(@"switch is off");
        route_status = @"0";
        _tishiLab.text = @"货源声音提醒（已关闭）";
    }
    NSString *url = @"/mbtwz/route?action=setAllRouteIsremind";
    NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"route_status\":\"%@\"}",route_status]};
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:params FinishedLogin:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            [_dataArray removeAllObjects];
            
            NSArray *arr = [[NSArray alloc]initWithArray:[dic[@"response"][0] objectForKey:@"myrote"]];
            
            for (NSDictionary* dict in arr) {
                MylineModel1* model = [[MylineModel1 alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [_tableview reloadData];
        }else{
            jxt_showToastTitle([dic objectForKey:@"msg"], 1);
        }
        NSLog(@"%@",dic);
        
    }];

}
- (void)rightToLastViewController{
    LineFaBuViewController1 *line = [[LineFaBuViewController1 alloc]init];
    [self.navigationController pushViewController:line animated:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    mylineTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"mylineTableViewCell1"];
    if (!cell) {
        cell = (mylineTableViewCell1 *)[[[NSBundle mainBundle]loadNibNamed:@"mylineTableViewCell1" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count) {
        MylineModel1 *model = _dataArray[indexPath.row];
        cell.titleLab.text = [NSString stringWithFormat:@"%@%@%@—%@%@%@",[Command convertNull:model.sprovince],[Command convertNull:model.scity],[Command convertNull:model.scounty],[Command convertNull:model.eprovince],[Command convertNull:model.ecity],[Command convertNull:model.ecounty]];
        cell.otherLab.text = [NSString stringWithFormat:@"货源数 %@",model.hynumbers];
        if ([model.remind intValue]==1) {
            cell.imageview.image = [UIImage imageNamed:@"铃声"];
        }else{
            cell.imageview.image = [UIImage imageNamed:@"静音"];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MylineModel1 *model = _dataArray[indexPath.row];
    MyLineDetailsViewController1 *line = [[MyLineDetailsViewController1 alloc]init];
    line.sprovince = [Command convertNull:model.sprovince];
    line.scity = [Command convertNull:model.scity];
    line.scounty = [Command convertNull:model.scounty];
    line.eprovince = [Command convertNull:model.eprovince];
    line.ecity = [Command convertNull:model.ecity];
    line.ecounty = [Command convertNull:model.ecounty];
    line.cartypenames = [Command convertNull:model.car_types];
    line.carlengthnames = [Command convertNull:model.car_length];
    line.routeid = [NSString stringWithFormat:@"%@",model.id];
    line.remind = [NSString stringWithFormat:@"%@",model.remind];
    if ([model.usecar_type intValue]==0) {
        line.use_car_typeStr = @"2";
    }else{
        line.use_car_typeStr = [NSString stringWithFormat:@"%d",[model.usecar_type intValue]-1];
    }
    
    
    [self.navigationController pushViewController:line animated:YES];
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
