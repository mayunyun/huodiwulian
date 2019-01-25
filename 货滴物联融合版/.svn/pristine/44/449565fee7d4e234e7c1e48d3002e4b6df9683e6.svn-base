//
//  YHJlingquViewController1.m
//  MaiBaTe
//
//  Created by LONG on 2017/10/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YHJlingquViewController1.h"
#import "YHJlingquTableViewCell1.h"

@interface YHJlingquViewController1 ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation YHJlingquViewController1

- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavBarHeight, UIScreenW, UIScreenH-NavBarHeight)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_tableview];
        
        
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 20)];
        _tableview.tableHeaderView = head;
        
        [_tableview registerNib:[UINib nibWithNibName:@"YHJlingquTableViewCell1" bundle:nil] forCellReuseIdentifier:@"YHJlingquTableViewCell1"];
        
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

        
    }
    return _tableview;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券领取";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭
    _dataArr = [[NSMutableArray alloc]init];
    [self tableview];
    [self dataRequest];
    
}
//下拉刷新
- (void)loadNewData{
    
    [self dataRequest];
    [_tableview.mj_header endRefreshing];
    
}
- (void)dataRequest{
    [_dataArr removeAllObjects];
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:@"/mbtwz/WxCoupon?action=getCoupon" Parameters:nil FinishedLogin:^(id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",array);
        if (!IsEmptyValue(array)) {
            for (NSDictionary *dic in array) {
                YouHuiModel1 *model=[[YouHuiModel1 alloc]init];
                [model setValuesForKeysWithDictionary:dic];
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
    return 165*MYWIDTH;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YHJlingquTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"YHJlingquTableViewCell1"];
    if (!cell) {
        cell=[[YHJlingquTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHJlingquTableViewCell1"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count) {
        YouHuiModel1 *model = _dataArr[indexPath.row];
        cell.cheap_descript.text = [NSString stringWithFormat:@"%@",model.cheap_descript];
        cell.cheap_coupon_count.text = [NSString stringWithFormat:@"当前剩余:%@张",model.cheap_coupon_count];
        cell.cheap_equal_money.text = [NSString stringWithFormat:@"%@",model.cheap_equal_money];
        cell.cheap_equal_money.adjustsFontSizeToFitWidth = YES;
        cell.cheapBut.tag = indexPath.row+150;
        [cell.cheapBut addTarget:self action:@selector(cheapBut:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return cell;
}
- (void)cheapBut:(UIButton *)but{
    YouHuiModel1 *model = _dataArr[but.tag-150];

    NSString* urlstr = @"/mbtwz/WxCoupon?action=getCustTicketsMax";
    NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"couponid\":\"%@\"}",model.id]};
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:urlstr Parameters:params FinishedLogin:^(id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *count = [NSString stringWithFormat:@"%@",[array[0] objectForKey:@"cheap_coupon_count"]];
        //NSSLog(@">>>%@",array);
        if ([count intValue]>0) {
            
            NSString* urlstr = @"/mbtwz/WxCoupon?action=addMyCoupon";
            NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"couponid\":\"%@\"}",model.id]};
            [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:urlstr Parameters:params FinishedLogin:^(id responseObject) {
                
                NSString* str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                //NSSLog(@">>>%@",str);
                if ([str rangeOfString:@"true"].location!=NSNotFound) {
                    jxt_showToastTitle(@"优惠券领取成功", 1);
                    [self dataRequest];
                }else{
                    jxt_showToastTitle(@"优惠券领取失败", 1);
                }
                
            }];
        }else{
            

            jxt_showToastTitle(@"优惠券数量不足！", 1);
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    NSLog(@"%ld",indexPath.row);
}

@end
