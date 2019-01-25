//
//  MyPurseViewController1.m
//  MaiBaTe
//
//  Created by LONG on 17/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyPurseViewController1.h"
#import "MyPurseTableViewCell1.h"
#import "MyYeEViewController1.h"
#import "YouHuiJuanViewController1.h"
#import "ScoresViewController1.h"
#import "ETCRechargeViewController1.h"
#import "QiandaoViewController1.h"

#import "MeModel1.h"
@interface MyPurseViewController1 ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_headtitle;
    UIImageView *_headview;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation MyPurseViewController1
- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight-88);
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        //_tableview.scrollEnabled =NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        UIImageView *bgimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*MYWIDTH)];
        bgimage.image = [UIImage imageNamed:@"钱包背景"];
    
        UIImageView *headviewBG = [[UIImageView alloc]initWithFrame:CGRectMake(bgimage.width/2-55*MYWIDTH, bgimage.height/2-75*MYWIDTH, 110*MYWIDTH, 110*MYWIDTH)];
        headviewBG.image = [UIImage imageNamed:@"默认头像BG"];
        headviewBG.layer.masksToBounds = YES;
        headviewBG.layer.cornerRadius = headviewBG.width/2;
        [bgimage addSubview:headviewBG];
        
        _headview = [[UIImageView alloc]initWithFrame:CGRectMake(12*MYWIDTH, 12*MYWIDTH, 86*MYWIDTH, 86*MYWIDTH)];
        _headview.image = [UIImage imageNamed:@"默认头像"];
        _headview.layer.masksToBounds = YES;
        _headview.layer.cornerRadius = _headview.width/2;
        [headviewBG addSubview:_headview];
        
        _headtitle  = [[UILabel alloc]initWithFrame:CGRectMake(0, headviewBG.bottom+10*MYWIDTH, kScreenWidth, 20)];
        _headtitle.text = @"货滴用户";
        _headtitle.textAlignment = NSTextAlignmentCenter;
        _headtitle.textColor = UIColorFromRGB(0x333333);
        _headtitle.font = [UIFont systemFontOfSize:16];
        [bgimage addSubview:_headtitle];
        
        _tableview.tableHeaderView = bgimage;
        
        [_tableview registerClass:[MyPurseTableViewCell1 class] forCellReuseIdentifier:NSStringFromClass([MyPurseTableViewCell1 class])];
        
    }
    return _tableview;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [self loadNew];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭

    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的钱包";
    [self tableview];

}
#pragma 在这里面请求数据
- (void)loadNew
{
    [_dataArr removeAllObjects];
    
    NSString *XWURLStr = @"/mbtwz/personal?action=getPersonalInfo";
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:XWURLStr Parameters:nil FinishedLogin:^(id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"我的信息%@",array);
        //建立模型
        if (!(responseObject == nil)) {
            MeModel1 *model=[[MeModel1 alloc]init];
            [model setValuesForKeysWithDictionary:array[0]];
            //追加数据
            [_dataArr addObject:model];
            [self settitledata];
        }
        [_tableview reloadData];
        
    }];
}
- (void)settitledata{
    MeModel1 *model = _dataArr[0];
    if ([[NSString stringWithFormat:@"%@",model.custname] isEqualToString:@"(null)"]) {
        _headtitle.text = @"货滴用户";
    }else{
        _headtitle.text = model.custname;
    }
    
    if (![[NSString stringWithFormat:@"%@",model.autoname] isEqualToString:@"(null)"]) {
        NSString *image = [NSString stringWithFormat:@"%@/%@/%@",_Environment_Domain,model.folder,model.autoname];
        NSLog(@"%@",image);
        [_headview sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*MYWIDTH;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Class MainClass = [MyPurseTableViewCell1 class];
    MyPurseTableViewCell1 *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MainClass)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *data = @[@"余额",@"优惠券",@"积分",@"ETC充值",@"保险"];
    NSArray *image = @[@"余额",@"优惠券",@"积分",@"ETC缴费",@"保险"];
    [cell setdata:data[indexPath.row] image:image[indexPath.row] push:@"0"];
    if (indexPath.row == 0) {
        cell.otherView.text = @"0元";
    }else if (indexPath.row == 1){
        cell.otherView.text = @"0张";
    }else if (indexPath.row == 2){
        cell.otherView.text = @"0积分";
    }else{
        cell.otherView.text = @"";
    }
    if (_dataArr.count>0) {
        MeModel1 *model = _dataArr[0];
        if (indexPath.row == 0) {
            if ([[NSString stringWithFormat:@"%@",model.balance] isEqualToString:@"(null)"]) {
                cell.otherView.text = @"0元";
            }else{
                cell.otherView.text = [NSString stringWithFormat:@"%.2f元",[model.balance floatValue]];
            }
        }else if (indexPath.row == 1){
            if ([[NSString stringWithFormat:@"%@",model.tickets] isEqualToString:@"(null)"]) {
                cell.otherView.text = @"0张";
            }else{
                cell.otherView.text = [NSString stringWithFormat:@"%@张",model.count];
            }
        }else if (indexPath.row == 2){
            if ([[NSString stringWithFormat:@"%@",model.scores] isEqualToString:@"(null)"]) {
                cell.otherView.text = @"0积分";
            }else{
                cell.otherView.text = [NSString stringWithFormat:@"%@积分",model.scores];
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyYeEViewController1 *MyYuE = [[MyYeEViewController1 alloc]init];
        [self.navigationController pushViewController:MyYuE animated:YES];
    }else if (indexPath.row == 1){
        YouHuiJuanViewController1 *YouHuiJuan = [[YouHuiJuanViewController1 alloc]init];
        if (_dataArr.count>0) {
           // YouHuiJuan.model = _dataArr[0];
        }
        [self.navigationController pushViewController:YouHuiJuan animated:YES];
    }else if (indexPath.row == 2){
        QiandaoViewController1 *ScoresView = [[QiandaoViewController1 alloc]init];

//        ScoresViewController1 *ScoresView = [[ScoresViewController1 alloc]init];
//        if (_dataArr.count>0) {
//            ScoresView.model = _dataArr[0];
//        }
        [self.navigationController pushViewController:ScoresView animated:YES];
    }else if (indexPath.row == 3){
        ETCRechargeViewController1 *MyYuE = [[ETCRechargeViewController1 alloc]init];
        MyYuE.push = @"1";
        [self.navigationController pushViewController:MyYuE animated:YES];
    }else if (indexPath.row == 4){
        jxt_showAlertOneButton(@"提示", @"正在开发中",@"确定" , ^(NSInteger buttonIndex) {
            
        });
    }
    
    
    NSLog(@"%ld",indexPath.row);
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
