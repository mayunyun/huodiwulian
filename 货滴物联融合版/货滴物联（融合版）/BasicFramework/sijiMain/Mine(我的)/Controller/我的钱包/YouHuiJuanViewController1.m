//
//  YouHuiJuanViewController1.m
//  MaiBaTe
//
//  Created by LONG on 17/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YouHuiJuanViewController1.h"
#import "YouHuiJuanTableViewCell1.h"
#import "YHJlingquViewController1.h"
@interface YouHuiJuanViewController1 ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation YouHuiJuanViewController1

- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavBarHeight, kScreenWidth, kScreenHeight-NavBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tableview.tableHeaderView = head;
        UIView *food = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20*MYWIDTH)];
        
        //        UIButton *shixiao = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-75*MYWIDTH, 20*MYWIDTH, 150*MYWIDTH, 40*MYWIDTH)];
        //        [shixiao setTitle:@"查看已失效优惠券" forState:UIControlStateNormal];
        //        [shixiao setBackgroundColor:UIColorFromRGB(0x999999)];
        //        shixiao.titleLabel.font = [UIFont systemFontOfSize:13];
        //        shixiao.layer.cornerRadius = 5;
        //        [food addSubview:shixiao];
        _tableview.tableFooterView = food;
        [_tableview registerNib:[UINib nibWithNibName:@"YouHuiJuanTableViewCell1" bundle:nil] forCellReuseIdentifier:@"YouHuiJuanTableViewCell1"];
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _tableview;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    _dataArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭
    [self tableview];
    [self dataRequest];
    //    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-115*MYWIDTH, kScreenHeight/2-115*MYWIDTH, 230*MYWIDTH, 230*MYWIDTH)];
    //    image.image = [UIImage imageNamed:@"建设中"];
    //    [self.view addSubview:image];
    
}
//下拉刷新
- (void)loadNewData{
    
    [self dataRequest];
    [_tableview.mj_header endRefreshing];
    
}
- (void)dataRequest{
    [_dataArr removeAllObjects];
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:@"/mbtwz/WxCoupon?action=getCustTickets" Parameters:nil FinishedLogin:^(id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",array);
        if (!IsEmptyValue(array)) {
            for (NSDictionary *dic in array) {
                YouHuiModel1 *model=[[YouHuiModel1 alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
            }
            [_tableview reloadData];
        }
        
    }];
    
    //判断有无优惠券
    NSString *youhuiURLStr = @"/mbtwz/WxCoupon?action=getCoupon";
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:youhuiURLStr Parameters:nil FinishedLogin:^(id responseObject) {
        NSArray *Arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"优惠状态:%@",Arr);
        if (Arr.count) {
            
            
            UIButton *TastoVersamento = [UIButton buttonWithType:UIButtonTypeCustom];
            [TastoVersamento setImage:[UIImage imageNamed:@"领劵图标"] forState:UIControlStateNormal];
            [TastoVersamento addTarget:self action:@selector(rightToLastViewController) forControlEvents:UIControlEventTouchUpInside];
            [TastoVersamento setFrame:CGRectMake(0, -5, 40, 40)];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:TastoVersamento];
            
        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        
    }];
}
- (void)rightToLastViewController{
    [Command isloginRequest:^(bool str) {
        if (str) {
            YHJlingquViewController1 *lingqu = [[YHJlingquViewController1 alloc]init];
            [self.navigationController pushViewController:lingqu animated:YES];
        }else{
            jxt_showAlertTwoButton(@"您目前还没有登录", @"是否前往登录", @"取消", ^(NSInteger buttonIndex) {
                
            }, @"前往", ^(NSInteger buttonIndex) {
                LoginVC1* vc = [[LoginVC1 alloc]init];
                [self presentViewController:vc animated:YES completion:nil];
            });
        }
    }];
    
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*MYWIDTH;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YouHuiJuanTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"YouHuiJuanTableViewCell1"];
    if (!cell) {
        cell=[[YouHuiJuanTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouHuiJuanTableViewCell1"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count>0) {
        //圆角
        YouHuiModel1 *model = _dataArr[indexPath.row];
        cell.nameLab.text = [NSString stringWithFormat:@"%@",model.cheap_name];
        cell.nameLab.textColor = [UIColor whiteColor];
        cell.moneyLab.text = [NSString stringWithFormat:@"￥%.2f",[model.cheap_equal_money floatValue]];
        cell.moneyLab.textColor = [UIColor whiteColor];
        cell.cheap_descriptLab.text = [NSString stringWithFormat:@"%@",model.cheap_descript];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_push isEqualToString:@"1"]) {
        YouHuiModel1 *model = _dataArr[indexPath.row];
        if (_youhuiVaule) {
            _youhuiVaule(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
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
