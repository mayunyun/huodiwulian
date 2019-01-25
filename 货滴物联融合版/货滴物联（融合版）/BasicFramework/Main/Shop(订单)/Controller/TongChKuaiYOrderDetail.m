//
//  TongChKuaiYOrderDetail.m
//  BasicFramework
//
//  Created by LONG on 2018/2/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "TongChKuaiYOrderDetail.h"
#import "TCHKuaiYOrderDetailHeaderCell.h"
#import "AdressCell.h"
#import "ExNeedCell.h"
#import "TotalPriceCell.h"
#import "DriveInfoCell.h"
#import "DriverOrderInfoCell.h"
#import "CancleOrderView.h"
#import "CDZStarsControl.h"
#import "CustomAnnotationView.h"
#import "PLTagView.h"

@interface TongChKuaiYOrderDetail ()<UITableViewDataSource,UITableViewDelegate,CDZStarsControlDelegate,UITextViewDelegate,MAMapViewDelegate,PLTagViewDelegate, PLTagViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * detailArr;
@property (nonatomic,strong)CancleOrderView * cancleView;
@property (nonatomic,strong)UIView * pcancelView;
@property (nonatomic, strong) CDZStarsControl *starsControl;
@property (nonatomic,strong)UITextView * inputTV;
@property (nonatomic,strong)UIButton * exitBtn;
@property (nonatomic,strong)UIButton * commitBtn;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSArray *mapGpsArr;
@property (nonatomic, strong) NSArray *lines;
@end

@implementation TongChKuaiYOrderDetail

{
    UIView * starView;
    UILabel *_placeHolderLabel;
    NSString * starScore;
    NSString * fee;
    //NSArray * arr;
    UILabel * feeLabel;
    PLTagView *_typeview;
    NSMutableArray *_arr;
    UIButton *_PLbutton;
    
    // 黑色的背景
    UIButton * backBtn;
    // 整个弹出框
    UIView *applyInputView;
    // TextView的输入框
    UITextField * jkTextField;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDetail];
    [self requestmapGps];

}
- (void)backAction{
    if ([self.push isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"货滴快运单详情";
    _dataArr = [[NSMutableArray alloc]init];
    _detailArr = [NSMutableArray array];
    _arr = [[NSMutableArray alloc]init];

    [self requestDataForRate];
    
    [self tableview];
    starScore = @"5";
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:YES];
    [SMAlert setcontrolViewbackgroundColor:[UIColor clearColor]];
    
    _typeview = [[PLTagView alloc] init];
    _typeview.frame = CGRectMake(1, 1, UIScreenW-90*MYWIDTH, 0);
    _typeview.themeColor = MYColor;
    _typeview.backgroundColor = [UIColor whiteColor];
    _typeview.tagCornerRadius = 0;
    _typeview.dataSource = self;
    _typeview.delegate = self;
    _typeview.numer = 3;
    [self.view addSubview:_typeview];
}

//下拉刷新
- (void)loadNewData{
    [self requestDetail];
    [self requestmapGps];
    [_tableview.mj_header endRefreshing];
}
-(void)requestmapGps{
    NSString *url = @"/huodigps?action=queryGps";
    NSDictionary * dic =@{@"orderno":self.orderStr};
    NSDictionary* KCparams = @{@"page":@"1",@"rows":@"5000",@"params":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
    
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dic objectForKey:@"rows"]);
        self.mapGpsArr = [dic objectForKey:@"rows"];
        if (self.mapGpsArr.count>0) {
            NSMutableArray *arr = [NSMutableArray array];
            
            CLLocationCoordinate2D line2Points[self.mapGpsArr.count];
            
            for (int i=0; i<self.mapGpsArr.count; i++) {
                line2Points[i].latitude = [[self.mapGpsArr[i] objectForKey:@"lattitude"] floatValue];
                line2Points[i].longitude = [[self.mapGpsArr[i] objectForKey:@"longitude"] floatValue];
            }
            MAPolyline *line2 = [MAPolyline polylineWithCoordinates:line2Points count:self.mapGpsArr.count];
            [arr addObject:line2];
            
            self.lines = [NSArray arrayWithArray:arr];
        }
        [_tableview reloadData];
    }];
}
-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate tag:(NSString *)tag
{
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title    = tag;
    annotation.subtitle = @"";
    
    [self.mapView addAnnotation:annotation];
}
-(void)requestDetail{
    NSString *url = @"/mbtwz/logisticssendwz?action=searchKuaiyunOrderDetail";
    NSDictionary * dic =@{@"orderno":self.orderStr};
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        [_detailArr removeAllObjects];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"订单详情%@",arr);
        for (NSDictionary *dic in arr) {
            TCHKuaiYModel *model=[[TCHKuaiYModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_detailArr addObject:model];
        }
        TCHKuaiYModel * model;
        if (_detailArr.count) {
            model = _detailArr[0];
        }
        if ([model.driver_orderstatus intValue]==2&&[model.isevaluate intValue]==0) {
            _PLbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bottom-50*MYWIDTH, UIScreenW, 50*MYWIDTH)];
            _PLbutton.backgroundColor = MYColor;
            [_PLbutton setTitle:@"去评价" forState:UIControlStateNormal];
            [_PLbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_PLbutton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            _tableview.tableFooterView = _PLbutton;
        }
        
        [_tableview reloadData];
        
    }];
    
    //
    NSString *PLURLStr = @"/mbtwz/logisticssendwz?action=selectEvaluationList";
    NSDictionary* PLparams = @{@"params":[NSString stringWithFormat:@"{\"type\":\"0\",\"custid\":\"%@\"}",self.custid]};
    NSLog(@"参数==%@",PLparams);
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:PLURLStr Parameters:PLparams FinishedLogin:^(id responseObject) {
        
        NSDictionary *dataarr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSMutableDictionary *dic in [dataarr objectForKey:@"response"]) {
            [dic setValue:@"0" forKey:@"up"];
            [_arr addObject:dic];
        }
        
        NSLog(@"zulin%@",_arr);
        
        
        [_typeview reloadData];
    }];
}
-(void)requestDataForRate{
    NSString *url = @"/mbtwz/logisticssendwz?action=searchfee";
    
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:nil FinishedLogin:^(id responseObject) {
        
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求费率%@",arr);
        if (arr.count == 0||arr == nil) {
            fee = @"0";
        }else{
            fee = [NSString stringWithFormat:@"%.2f",[arr[0][@"fee"] floatValue]*100];
        }
        
    }];
}
-(void)CommitBtnClicked:(UIButton *)sender{
    TCHKuaiYModel * model;
    if (_detailArr.count) {
        model = _detailArr[0];
    }
    sender.userInteractionEnabled = NO;
    NSString *selevalueids;
    for (NSDictionary *dic in _arr) {
        if ([[dic objectForKey:@"up"] isEqualToString:@"1"]) {
            selevalueids = [NSString stringWithFormat:@"%@,%@",selevalueids,[dic objectForKey:@"id"]];
        }
    }
    NSString *str1 = @"";
    if (selevalueids.length>6) {
        str1 = [selevalueids substringFromIndex:7];
    }
    
    NSString *url = @"/mbtwz/logisticssendwz?action=evlateOrder_by_sel";
    NSDictionary * dic;
    if ([_inputTV.text isEqualToString:@""]) {//默认不填任何信息是好评
        dic =@{@"order_id":model.id,@"driver_fraction":starScore,@"note":@"默认好评",@"driverid":model.driver_custid,@"ordertype":@"2",@"evalute_type":@"0",@"selevalueids":str1};
    }else{
        dic =@{@"order_id":model.id,@"driver_fraction":starScore,@"note":_inputTV.text,@"driverid":model.driver_custid,@"ordertype":@"2",@"evalute_type":@"0",@"selevalueids":str1};
    }
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"提交评价%@",str);
        
        if ([str containsString:@"true"]) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // do something
                [SMAlert hide:NO];
                _cancleView.hidden = YES;
                TCHKuaiYModel * model = _detailArr[0];
                model.cust_orderstatus = @"2";
                jxt_showToastTitle(@"提交评价成功", 1);
                sender.userInteractionEnabled = NO;
                _PLbutton.hidden = YES;
                _tableview.tableFooterView = nil;
                [_tableview reloadData];
                
            });
        }else{
            jxt_showToastTitle(@"提交评价失败", 1);
            sender.userInteractionEnabled = NO;
        }
        
    }];
}

-(void)startOrder{
    NSString *url = @"/mbtwz/logisticssendwz?action=startKuaiyunOrder";
    NSDictionary * dic =@{@"orderno":self.orderStr};
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"开始订单%@",str);
        if ([str containsString:@"true"]) {
            jxt_showToastTitle(@"订单已开始", 2);
            TCHKuaiYModel * model = _detailArr[0];
            model.cust_orderstatus = @"1";
            //刷新完数据滚动到顶部
            [_tableview setContentOffset:CGPointMake(0,0) animated:YES];
            [_tableview reloadData];
        }else{
            jxt_showToastTitle(@"开始订单失败", 2);
        }
        
    }];
}
//结束订单
-(void)endingOrderData{
    NSString *url = @"/mbtwz/logisticssendwz?action=finishKuaiyunOrder";
    TCHKuaiYModel * model = _detailArr[0];
    NSDictionary * dic =@{@"orderno":self.orderStr,
                          @"order_money":model.settheprice,
                          @"driverid":model.driver_custid
                          };
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"结束订单%@",str);
        if ([str containsString:@"true"]) {
            
            TCHKuaiYModel * model = _detailArr[0];
            model.cust_orderstatus = @"2";
            
            
            _PLbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bottom-50*MYWIDTH, UIScreenW, 50*MYWIDTH)];
            _PLbutton.backgroundColor = MYColor;
            [_PLbutton setTitle:@"去评价" forState:UIControlStateNormal];
            [_PLbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_PLbutton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            _tableview.tableFooterView = _PLbutton;
            [_tableview reloadData];
        }else{
            jxt_showToastTitle(@"结束订单失败", 2);
        }
        
    }];
}
- (void)buttonClick{
    starView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW-60, UIScreenH*1.4/3)];
    starView.backgroundColor = [UIColor whiteColor];
    starView.layer.cornerRadius = 8.f;
    starView.layer.masksToBounds = YES;
    _typeview.frame = CGRectMake(20*MYWIDTH, 50*MYWIDTH, starView.width-40*MYWIDTH, 100*MYWIDTH);
    [starView addSubview:_typeview];
    [starView addSubview:self.starsControl];
    [starView addSubview:self.exitBtn];
    [starView addSubview:self.inputTV];
    [starView addSubview:self.commitBtn];
    [SMAlert showCustomView:starView];
}
- (NSInteger)PLnumOfItemstagView:(PLTagView *)tagView  {
    
    if (_typeview == tagView){
        return _arr.count;
    }
    return 0;
}

- (NSString *)PLtagView:(PLTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    if (_typeview == tagView){
        return [NSString stringWithFormat:@"%@(%@)",[_arr[index] objectForKey:@"content"],[_arr[index] objectForKey:@"usenumber"]];
    }
    return nil;
}
- (void)PLtagView:(PLTagView *)tagView heightUpdated:(CGFloat)height{
    NSLog(@">>>>>>>???>>>>>%.2f",height);
    
}

- (void)PLtagView:(PLTagView *)tagView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@">>>>>>>???>>>>>%zd",index);
    //创建一个消息对象
    //_integer = [NSString stringWithFormat:@"%zd",index];
    if ([[NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"up"]] isEqualToString:@"0"]) {
        [_arr[index] setValue:@"1" forKey:@"up"];
    }else{
        [_arr[index] setValue:@"0" forKey:@"up"];
    }
    
}
-(void)DriverSyData{
    TCHKuaiYModel * model;
    if (_detailArr.count) {
        model  = _detailArr[0];
    }
    NSString *url = @"/mbtwz/logisticssendwz?action=overTime";
    NSDictionary * dic =@{@"orderno":self.orderStr,@"owner_createtime":model.createtime,@"siji_findtime":model.siji_singletime,@"order_money":model.settheprice,@"driverid":model.driver_custid};
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"司机失约%@",str);
        if ([str containsString:@"true"]) {
            jxt_showToastTitle(@"提交成功", 2);
            TCHKuaiYModel * model = _detailArr[0];
            model.cust_orderstatus = @"-1";
            //刷新完数据滚动到顶部
            [_tableview setContentOffset:CGPointMake(0,0) animated:YES];
            [_tableview reloadData];
        }else if([str isEqualToString:@""]){
            //            NSString * string = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            jxt_showToastTitle(@"提交失败", 2);
        }else{
            NSString * string = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            jxt_showToastTitle(string, 2);
        }

    }];
}
-(void)cancelOrderData{
    TCHKuaiYModel * model;
    if (_detailArr.count) {
        model = _detailArr[0];
    }
    NSString *url = @"/mbtwz/logisticssendwz?action=cancelKuaiyunOrder";
    NSDictionary * dic =@{@"orderno":self.orderStr,@"siji_findtime":model.siji_singletime,@"order_money":model.settheprice};
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"取消订单%@",str);
        UIImageView * canView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250*MYWIDTH, 220*MYWIDTH)];
        canView.image = [UIImage imageNamed:@"已取消"];
        
        UILabel * note1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, canView.height/2+10*MYWIDTH, canView.width, 20*MYWIDTH)];
        note1Label.text = @"订单已取消";
        note1Label.textColor = UIColorFromRGB(0x484848);
        note1Label.textAlignment = NSTextAlignmentCenter;
        note1Label.font = [UIFont systemFontOfSize:16*MYWIDTH];
        [canView addSubview:note1Label];
        feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, note1Label.bottom +10*MYWIDTH, note1Label.width, 20*MYWIDTH)];
        feeLabel.text = [NSString stringWithFormat:@"已扣除您%@%%费用",fee];
        feeLabel.textColor = UIColorFromRGB(0x484848);
        feeLabel.textAlignment = NSTextAlignmentCenter;
        feeLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        [canView addSubview:feeLabel];
        if ([str isEqualToString:@"\"trueTimeout\""]) {
            feeLabel.hidden = NO;
            [SMAlert showCustomView:canView];
            [SMAlert hideCompletion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if ([str isEqualToString:@"\"true\""]){
            feeLabel.hidden = YES;
            [SMAlert showCustomView:canView];
            [SMAlert hideCompletion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            jxt_showToastTitle(@"取消订单失败", 1);
        }
        
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 4;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 236;
    }else if (indexPath.section == 1){
        TCHKuaiYModel * model;
        if (_detailArr.count) {
            model = _detailArr[0];
        }
        NSString * status = [NSString stringWithFormat:@"%@",model.cust_orderstatus];
        if ([status isEqualToString:@"0"]) {
            return 137;
        }
        return 320;
    }else if (indexPath.section == 2){
        if (indexPath.row==3) {
            if (_detailArr.count) {
                
                TCHKuaiYModel * model  = _detailArr[0];
                NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
                NSString *contentStr= [Command convertNull:model.remarks];
                if ([contentStr isEqualToString:@""]) {
                    return 40;
                }
                CGSize size=[contentStr boundingRectWithSize:CGSizeMake(UIScreenW-129, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
                return 30+size.height;
            }
        }
        return 40;
    }else if (indexPath.section == 4){
        return 80;
    }else{
        TCHKuaiYModel * model;
        if (_detailArr.count) {
            model = _detailArr[0];
        }
        NSString * driver_custId = [NSString stringWithFormat:@"%@",model.driver_custid];
        if ([[Command convertNull:driver_custId] isEqualToString:@""]||[model.driver_custid intValue] == 0) {
            return 80;
        }else{
            return 120;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 240;
    }
    return 1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        __weak typeof(self) weakSelf = self;
        //        __weak typeof(_cancleView) _weakcancleView = _cancleView;
        _cancleView = [CancleOrderView headerViewWithTableView:tableView];
        if (_detailArr.count) {
            TCHKuaiYModel * model  = _detailArr[0];
            NSArray * arr = @[model.cust_orderstatus,model.driver_orderstatus];
            _cancleView.status = arr;
        }
        [_cancleView setCancleBtnBlock:^{
            //取消订单视图
            UIView * canView = [weakSelf cancelView];
            canView.backgroundColor = [UIColor whiteColor];
            [SMAlert showCustomView:canView];
            
        }];
        [_cancleView setStartBtnBlock:^{
            jxt_showAlertTwoButton(@"提示", @"确认开始订单", @"取消", ^(NSInteger buttonIndex) {
                
            }, @"确定", ^(NSInteger buttonIndex) {
                [weakSelf startOrder];
            });
            
        }];
        [_cancleView setEndBtnBlock:^{
            jxt_showAlertTwoButton(@"提示", @"确认结束订单", @"取消", ^(NSInteger buttonIndex) {
                
            }, @"确定", ^(NSInteger buttonIndex) {
                [weakSelf endingOrderData];
            });
            
        }];
        [_cancleView setDriverSyBlock:^{
            //            jxt_showAlertTwoButton(@"提示", @"确认提交司机失约", @"取消", ^(NSInteger buttonIndex) {
            //
            //            }, @"确定", ^(NSInteger buttonIndex) {
            //                [weakSelf DriverSyData];
            //            });
            [weakSelf DriverSyData];
        }];
        return _cancleView;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{//头视图
    if (section==2) {
        return 0;
    }
    return 20;
}
//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * stringCell = @"TCHKuaiYOrderDetailHeaderCell";
        TCHKuaiYOrderDetailHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        if (_detailArr.count) {
            cell.model = _detailArr[indexPath.section];
            [cell.FBut addTarget:self action:@selector(fphoneClick) forControlEvents:UIControlEventTouchUpInside];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        TCHKuaiYModel * model;
        if (_detailArr.count) {
            model = _detailArr[0];
        }
        static NSString * stringCell = @"AdressCell";
        AdressCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        cell.startPosition.text = [NSString stringWithFormat:@"%@",model.startaddress];
        cell.endPosition.text = [NSString stringWithFormat:@"%@",model.endaddress];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString * status = [NSString stringWithFormat:@"%@",model.cust_orderstatus];
        if (![status isEqualToString:@"0"]) {
            self.mapView = [[MAMapView alloc] initWithFrame:cell.BGmap.bounds];
            self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.mapView setZoomLevel:13 animated:NO];
            
            self.mapView.delegate = self;
            
            [cell.BGmap addSubview:self.mapView];
            
            if (self.mapGpsArr.count>0) {
                if (self.mapGpsArr.count%2) {
                    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([[self.mapGpsArr[(self.mapGpsArr.count-1)/2] objectForKey:@"lattitude"] floatValue], [[self.mapGpsArr[(self.mapGpsArr.count-1)/2] objectForKey:@"longitude"] floatValue]) animated:YES];
                }else{
                    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([[self.mapGpsArr[self.mapGpsArr.count/2] objectForKey:@"lattitude"] floatValue], [[self.mapGpsArr[self.mapGpsArr.count/2] objectForKey:@"longitude"] floatValue]) animated:YES];
                }
                
                [self.mapView addOverlays:self.lines];
                
                [self addAnnotationWithCooordinate:CLLocationCoordinate2DMake([[self.mapGpsArr[0] objectForKey:@"lattitude"] floatValue], [[self.mapGpsArr[0] objectForKey:@"longitude"] floatValue]) tag:@"1100"];
                [self addAnnotationWithCooordinate:CLLocationCoordinate2DMake([[self.mapGpsArr[self.mapGpsArr.count-1] objectForKey:@"lattitude"] floatValue], [[self.mapGpsArr[self.mapGpsArr.count-1] objectForKey:@"longitude"] floatValue]) tag:@"1101"];
            }
        }else{
            [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([model.startlatitude floatValue], [model.startlongitude floatValue]) animated:YES];
            [self.mapView addOverlays:self.lines];
            [self addAnnotationWithCooordinate:CLLocationCoordinate2DMake([model.startlatitude floatValue], [model.startlongitude floatValue]) tag:@"1100"];
        }
        return cell;
    }else if (indexPath.section == 2){
        static NSString * stringCell = @"ExNeedCell";
        ExNeedCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        if (indexPath.row==0) {
            cell.hide.hidden = YES;
        }else{
            cell.hide.hidden = NO;
        }
        
        cell.typeLabel.textColor = UIColorFromRGB(0x555555);
        cell.typeLabel.font = [UIFont systemFontOfSize:15];
        cell.contentLabel.textColor = UIColorFromRGB(0x555555);
        cell.contentLabel.font = [UIFont systemFontOfSize:15];
        NSArray *titleArr = @[@"车型",@"货物类型",@"货物重量/数量",@"备住"];
        cell.typeLabel.text = titleArr[indexPath.row];
        if (_detailArr.count) {
            TCHKuaiYModel * model  = _detailArr[0];
            NSString *weiVo = [[NSString alloc]init];
            if ([model.weight intValue]==0) {
                if ([model.volume intValue]==0) {
                    weiVo = [NSString stringWithFormat:@"%@吨",model.ton_weight];
                }else{
                    weiVo = [NSString stringWithFormat:@"%@吨/%@件",model.ton_weight,model.volume];
                }
            }else if ([model.ton_weight intValue]==0){
                if ([model.volume intValue]==0) {
                    weiVo = [NSString stringWithFormat:@"%@Kg",model.weight];
                }else{
                    weiVo = [NSString stringWithFormat:@"%@Kg/%@件",model.weight,model.volume];
                }
            }else if ([model.volume intValue]==0){
                if ([model.ton_weight intValue]==0) {
                    weiVo = [NSString stringWithFormat:@"%@Kg",model.weight];
                }else if ([model.weight intValue]==0){
                    weiVo = [NSString stringWithFormat:@"%@吨",model.ton_weight];
                }else{
                    weiVo = [NSString stringWithFormat:@"%@Kg、%@吨",model.weight,model.ton_weight];
                }
                
            }else{
                weiVo = [NSString stringWithFormat:@"%@Kg、%@吨/%@件",model.weight,model.ton_weight,model.volume];
            }
            
            NSArray * arr = @[model.cartypenames,model.cargotypenames,weiVo,model.remarks];
            cell.contentLabel.text = arr[indexPath.row];
//            if (indexPath.row==3) {
//                cell.contentLabel.textAlignment = NSTextAlignmentLeft;
//            }else{
//                cell.contentLabel.textAlignment = NSTextAlignmentRight;
//            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4){
        static NSString * stringCell = @"TotalPriceCell";
        TotalPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        if (_detailArr.count) {
            TCHKuaiYModel * model  = _detailArr[0];
            cell.price.text = [NSString stringWithFormat:@"%.2f",[model.settheprice floatValue]];
        }
        cell.price.borderStyle =  UITextBorderStyleNone;
        cell.price.backgroundColor = [UIColor whiteColor];
        cell.price.userInteractionEnabled = NO;
        cell.yuan1.text  = @"元";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        //未接单
        TCHKuaiYModel * model;
        if (_detailArr.count) {
            model = _detailArr[0];
        }
        NSString * driver_custId = [NSString stringWithFormat:@"%@",model.driver_custid];
        if ([[Command convertNull:driver_custId] isEqualToString:@""]||[model.driver_custid intValue] == 0) {
            static NSString * stringCell = @"DriveInfoCell";
            DriveInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
            }
            cell.sfcimage.hidden  = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            //接单
            static NSString * stringCell = @"DriverOrderInfoCell";
            DriverOrderInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
            }
            
            TCHKuaiYModel * model;
            
            if (_detailArr.count) {
                model = _detailArr[0];
//                NSString * status = [NSString stringWithFormat:@"%@",model.cust_orderstatus];
//                NSString * driver = [NSString stringWithFormat:@"%@",model.driver_orderstatus];
//                if ([status isEqualToString:@"0"]&&[driver isEqualToString:@"-2"]){
//                    cell.sfcimageview.hidden = NO;
//                }else{
                
                //}
                cell.driverName.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",model.driver_name]];
                
                
                NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.driver_phone]];
                [tncString addAttribute:NSUnderlineStyleAttributeName
                                  value:@(NSUnderlineStyleSingle)
                                  range:(NSRange){0,[tncString length]}];
                //此时如果设置字体颜色要这样
                [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]  range:NSMakeRange(0,[tncString length])];
                
                //设置下划线颜色...
                [tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:(NSRange){0,[tncString length]}];
                [cell.driverPhone setAttributedTitle:tncString forState:UIControlStateNormal];
                [cell.driverPhone addTarget:self action:@selector(driverPhone:) forControlEvents:UIControlEventTouchUpInside];
                
                
                cell.driverstar.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@星评分",model.cust_star]];
                cell.drivernum.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"交易%@笔",model.cust_num]];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
}
- (void)fphoneClick{
    [self setFphonecreateUI];
    [self pushApplyCase];
}
- (void)driverPhone:(UIButton *)but{
    TCHKuaiYModel * model;
    model = _detailArr[0];
    NSString *phone = [NSString stringWithFormat:@"拨打司机电话：%@",model.driver_phone];
    jxt_showAlertTwoButton(@"提示", phone, @"取消", ^(NSInteger buttonIndex) {
        
    }, @"确定", ^(NSInteger buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.driver_phone]]];
    });
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor blueColor];
        polylineRenderer.lineWidth   = 5.f;
        polylineRenderer.lineDashType = kMALineDashTypeNone;
        
        
        return polylineRenderer;
    }
    
    return nil;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = NO;
            annotationView.userInteractionEnabled = NO;
        }
        
        annotationView.portrait = [UIImage imageNamed:@"GPSHD"];
        if ([annotation.title isEqualToString:@"1100"]) {
            annotationView.name     = @"起点";
        }else{
            TCHKuaiYModel * model;
            if (_detailArr.count) {
                model = _detailArr[0];
            }
            NSString * status = [NSString stringWithFormat:@"%@",model.cust_orderstatus];
            if ([status isEqualToString:@"2"]) {
                annotationView.name     = @"终点";
            }else{
                annotationView.name     = @"进行中";
            }
            
        }
        
        
        return annotationView;
    }
    
    return nil;
}
//取消订单确认弹窗
-(UIView *)cancelView{
    if (_pcancelView == nil) {
        _pcancelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW-40, UIScreenH/3)];
        //        _pcancelView.layer.cornerRadius = 60.f;
        //        _pcancelView.layer.masksToBounds = YES;
        UILabel * cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*MYWIDTH, 10, _pcancelView.width-20, 30*MYWIDTH)];
        cancelLabel.text = @"取消订单";
        cancelLabel.textColor = MYColor;
        [_pcancelView addSubview:cancelLabel];
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, cancelLabel.bottom +5*MYWIDTH,_pcancelView.width, 1)];
        line.backgroundColor = MYColor;
        [_pcancelView addSubview:line];
        //        UIImageView * pointImagev1 = [[UIImageView alloc]initWithFrame:CGRectMake(20*MYWIDTH, line.bottom +22*MYWIDTH, 15*MYWIDTH, 15*MYWIDTH)];
        //        pointImagev1.image = [UIImage imageNamed:@"点"];
        //        [_pcancelView addSubview:pointImagev1];
        UILabel * note1Label = [[UILabel alloc]initWithFrame:CGRectMake(20*MYWIDTH, line.bottom +20*MYWIDTH, cancelLabel.width, 20*MYWIDTH)];
        note1Label.text = [NSString stringWithFormat:@"%@",@"◎ 司机接单前及接单三分钟内可免费取消"];
        note1Label.textColor = UIColorFromRGB(0x484848);
        note1Label.font = [UIFont systemFontOfSize:14*MYWIDTH];
        [_pcancelView addSubview:note1Label];
        //        UIImageView * pointImagev2 = [[UIImageView alloc]initWithFrame:CGRectMake(20*MYWIDTH, note1Label.bottom +12*MYWIDTH, 15*MYWIDTH, 15*MYWIDTH)];
        //        pointImagev2.image = [UIImage imageNamed:@"点"];
        //        [_pcancelView addSubview:pointImagev2];
        UILabel * note2Label = [[UILabel alloc]initWithFrame:CGRectMake(20*MYWIDTH, note1Label.bottom +10*MYWIDTH, note1Label.width, 20*MYWIDTH)];
        note2Label.text = [NSString stringWithFormat:@"◎ 司机接单三分钟后取消,将扣您%@%%的费用",fee];
        note2Label.textColor = UIColorFromRGB(0x484848);
        note2Label.font = [UIFont systemFontOfSize:14*MYWIDTH];
        [_pcancelView addSubview:note2Label];
        UIButton * continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        continueBtn.frame = CGRectMake(20, _pcancelView.height-60, (_pcancelView.width-60)/2, 40*MYWIDTH);
        [continueBtn setTitle:@"继续订单" forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(continueBtnCliked) forControlEvents:UIControlEventTouchUpInside];
        continueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [continueBtn setBackgroundColor:MYColor];
        continueBtn.layer.cornerRadius = 8.f;
        continueBtn.layer.masksToBounds = YES;
        [_pcancelView addSubview:continueBtn];
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(continueBtn.right+20, _pcancelView.height-60, (_pcancelView.width-60)/2, 40*MYWIDTH);
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnCliked) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setBackgroundColor:UIColorFromRGB(0xCCCCCC)];
        cancelBtn.layer.cornerRadius = 8.f;
        cancelBtn.layer.masksToBounds = YES;
        [_pcancelView addSubview:cancelBtn];
    }
    return _pcancelView;
}
-(void)quitPage{
    [SMAlert hide:NO];
    _cancleView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)continueBtnCliked{
    [SMAlert hide:NO];
}
-(void)cancelBtnCliked{
    [SMAlert hide:NO];
    [self cancelOrderData];
}
- (void)textViewDidChange:(UITextView *)textView

{
    
    if (textView.text.length == 0 )
        
    {
        
        _placeHolderLabel.text = @"请输入您的宝贵意见!";
        
    }
    
    else
        
    {
        
        _placeHolderLabel.text = @"";
        
    }
    
}
-(void)exitRemarkPage{
    [SMAlert hide:NO];
    _cancleView.hidden = YES;
    TCHKuaiYModel * model = _detailArr[0];
    model.cust_orderstatus = @"2";
    [_tableview reloadData];
}
#pragma remark -- 星星评价
- (void)starsControl:(CDZStarsControl *)starsControl didChangeScore:(CGFloat)score{
    //    self.label.text = [NSString stringWithFormat:@"%.1f",score];
    starScore = [NSString stringWithFormat:@"%.f",score];
    NSLog(@"星星的分数%@",starScore);
}

#pragma mark -- 懒加载
- (CDZStarsControl *)starsControl{
    if (!_starsControl) {
        
        _starsControl = [CDZStarsControl.alloc initWithFrame:CGRectMake(starView.width/2-100*MYWIDTH, 20*MYWIDTH, 200*MYWIDTH , 20*MYWIDTH) stars:5 starSize:CGSizeMake(20*MYWIDTH, 20*MYWIDTH) noramlStarImage:[UIImage imageNamed:@"11.2"] highlightedStarImage:[UIImage imageNamed:@"11.1"]];
        _starsControl.delegate = self;
        _starsControl.allowFraction = NO;
        _starsControl.score = 5.0f;
    }
    return _starsControl;
}
-(UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(starView.width- 140*MYWIDTH, starView.height-50*MYWIDTH, 100*MYWIDTH, 30*MYWIDTH);
        [_exitBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:MYColor forState:UIControlStateNormal];
        _exitBtn.titleLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        [_exitBtn setBackgroundColor:[UIColor whiteColor]];
        _exitBtn.layer.cornerRadius = 10.f;
        _exitBtn.layer.masksToBounds = YES;
        _exitBtn.layer.borderWidth = 0.5;
        _exitBtn.layer.borderColor = MYColor.CGColor;
        [_exitBtn addTarget:self action:@selector(exitRemarkPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
    
}

- (UITableView *)tableview{
    if (_tableview == nil) {
        UIView *baiview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 64)];
        if (statusbarHeight>20) {
            baiview.frame = CGRectMake(0, 0, UIScreenW, 88);
        }
        baiview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:baiview];
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, baiview.bottom, UIScreenW, UIScreenH-baiview.height) style:UITableViewStyleGrouped];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 0, UIScreenW, UIScreenH-34);
            
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        _tableview.scrollsToTop = YES;
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _tableview;
    
}
-(UITextView *)inputTV{
    if (!_inputTV) {
        _inputTV = [[UITextView alloc] initWithFrame:CGRectMake(20*MYWIDTH, self.starsControl.bottom+130*MYWIDTH, starView.width-40*MYWIDTH, starView.height/4)];
        _inputTV.font = [UIFont systemFontOfSize:15*MYWIDTH];
        _inputTV.layer.cornerRadius = 8.f;
        _inputTV.layer.borderWidth = 1.0f;
        _inputTV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _inputTV.delegate = self;
        _inputTV.backgroundColor = [UIColor clearColor];
        _inputTV.textColor = [UIColor blackColor];
        [starView addSubview:_inputTV];
        _inputTV.text = @"";
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*MYWIDTH, 5*MYWIDTH,starView.width-40*MYWIDTH, 20*MYWIDTH)];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.font = [UIFont systemFontOfSize:17*MYWIDTH];
        _placeHolderLabel.text = @"请输入您的宝贵意见!";
        [_inputTV addSubview:_placeHolderLabel];
        //给键盘加一个view收起键盘
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 30)];
        [topView setBarStyle:UIBarStyleBlack];
        UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
        [topView setItems:buttonsArray];
        [_inputTV setInputAccessoryView:topView];
        
    }
    return _inputTV;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(40*MYWIDTH, starView.height-50*MYWIDTH, 100*MYWIDTH, 30*MYWIDTH);
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        [_commitBtn setBackgroundColor:MYColor];
        [_commitBtn addTarget:self action:@selector(CommitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.layer.cornerRadius = 10.f;
        _commitBtn.layer.masksToBounds = YES;
    }
    return _commitBtn;
}
-(void)dismissKeyBoard
{
    [_inputTV resignFirstResponder];
}
#pragma mark 修改发货电话
-(void)setFphonecreateUI{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, UIScreenW,UIScreenH);
    backBtn.backgroundColor = [UIColor cyanColor];
    backBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    backBtn.alpha = 0.2;
    [window addSubview:backBtn];
    
    
    applyInputView = [[UIView alloc]initWithFrame:CGRectMake(25*MYWIDTH, (UIScreenH-175*MYWIDTH)/2, UIScreenW-50*MYWIDTH, 175*MYWIDTH)];
    applyInputView.alpha = 0;
    applyInputView.backgroundColor = [UIColor whiteColor];
    applyInputView.layer.cornerRadius = 10.f;
    applyInputView.clipsToBounds = NO;
    [window addSubview:applyInputView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20*MYWIDTH, 10*MYWIDTH, applyInputView.width-40*MYWIDTH, 18*MYWIDTH)];
    title.text = @"输入手机号";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16.f*MYWIDTH];
    [applyInputView addSubview:title];
    
    UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(0, title.bottom+10*MYWIDTH, applyInputView.width, 1)];
    lines.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [applyInputView addSubview:lines];
    UILabel * tfLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*MYWIDTH, lines.bottom+15*MYWIDTH, applyInputView.width-48*MYWIDTH, 42*MYWIDTH)];
    tfLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tfLabel.userInteractionEnabled = YES;
    [applyInputView addSubview:tfLabel];
    jkTextField = [[UITextField alloc]initWithFrame:CGRectMake(10*MYWIDTH, 8*MYWIDTH, tfLabel.width-20*MYWIDTH,30*MYWIDTH)];
    jkTextField.delegate = self;
    jkTextField.textColor = [UIColor blackColor];
    jkTextField.placeholder = @"输入手机号";
    //jkTextField.secureTextEntry = YES;
    jkTextField.keyboardType = UIKeyboardTypeNumberPad;
    jkTextField.textAlignment = NSTextAlignmentCenter;
    jkTextField.font = [UIFont systemFontOfSize:14.0f*MYWIDTH];
    [tfLabel addSubview:jkTextField];
    [Command placeholderColor:jkTextField str:jkTextField.placeholder color:UIColorFromRGBValueValue(0x333333)];
    
    CGFloat btnWidth = (applyInputView.width-60*MYWIDTH)/2;
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(20*MYWIDTH, tfLabel.bottom+25*MYWIDTH, btnWidth, 35*MYWIDTH)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16.f*MYWIDTH];
    [sureButton addTarget:self action:@selector(fphonesure) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setBackgroundColor:MYColor];
    sureButton.layer.cornerRadius = 6.f;
    sureButton.clipsToBounds = YES;
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyInputView addSubview:sureButton];
    
    UIButton *canleButton = [[UIButton alloc]initWithFrame:CGRectMake(sureButton.right+20*MYWIDTH, tfLabel.bottom+25*MYWIDTH, btnWidth, 35*MYWIDTH)];
    [canleButton setTitle:@"取消" forState:UIControlStateNormal];
    [canleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [canleButton setBackgroundColor:UIColorFromRGB(0xCDCDCD)];
    canleButton.titleLabel.font = [UIFont systemFontOfSize:16.f*MYWIDTH];
    canleButton.layer.cornerRadius = 6.f;
    canleButton.clipsToBounds = YES;
    [canleButton addTarget:self action:@selector(canle) forControlEvents:UIControlEventTouchUpInside];
    [applyInputView addSubview:canleButton];
}


#pragma mark 确定
-(void)fphonesure{
    [jkTextField resignFirstResponder];
    
    if ([jkTextField.text isEqualToString:@""]) {
        jxt_showToastTitle(@"手机号不能为空", 1);
    }else{
        
        NSString *url = @"/mbtwz/logisticssendwz?action=updateKuaiyunOrderFHcall";
        NSDictionary * dic =@{@"order_id":self.orderid,@"fahuocall":jkTextField.text};
        NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:dic]};//
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:url Parameters:KCparams FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"flag"] intValue]==200) {
                jxt_showToastTitle(@"修改成功", 1);
                [jkTextField resignFirstResponder];
                [SMAlert hide:NO];
                [backBtn removeFromSuperview];
                [applyInputView removeFromSuperview];
                [self loadNewData];
            }else{
                jxt_showAlertOneButton(@"提示", [NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]], @"确定", ^(NSInteger buttonIndex) {
                });
            }
            
        }];
        
    }
}
#pragma mark 取消
-(void)canle{
    [applyInputView removeFromSuperview];
    [backBtn removeFromSuperview];
}

#pragma mark 弹出申请框
-(void)pushApplyCase{
    
    [UIView animateWithDuration:0.36f animations:^{
        
        backBtn.alpha = 0.48;
        applyInputView.alpha = 1;
        
    }completion:^(BOOL finished) {
        
    }];
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
