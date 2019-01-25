//
//  TiBanWuLiuSjrzIngViewController.m
//  MaiBaTe
//
//  Created by LONG on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "TiBanWuLiuSjrzIngViewControllerNew1.h"
#import "TiBanWuLiuSjrzIngViewCellNew1.h"
#import "TiBanWuLiuSJRZViewCellNewPart1.h"
#import "WuLiuSJRZPhoneCellNew1.h"
#import "TiBanWuLiuSJRZViewControllerNew1.h"
#import "WuLiuSJRZViewControllerNew1.h"

@interface TiBanWuLiuSjrzIngViewControllerNew1 ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSMutableDictionary *dataDic;

@end

@implementation TiBanWuLiuSjrzIngViewControllerNew1


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; //autolayout 自适应关闭
    // Do any additional setup after loading the view.
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
    titleLab.text = @"替班司机认证";
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    
    [self rightBarTitleButtonTarget:self action:@selector(rightBarClick:) text:@"司机认证"];
    
    self.imageArr = [[NSMutableArray alloc]init];
    self.dataDic = [[NSMutableDictionary alloc]init];
    self.navigationItem.titleView = titleView;
    
    [self tableview];
    [self loadNew];
    
}
- (void)loadNew{
    
    
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:@"/mbtwz/drivercertification?action=checkDriverSPStatus" Parameters:nil FinishedLogin:^(id responseObject) {
        
        NSArray *Arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (Arr.count) {
            NSLog(@">>%@",Arr);
            
            [self.dataDic setValue:[Arr[0] objectForKey:@"driver_name"] forKey:@"driver_name"];
            [self.dataDic setValue:[Arr[0] objectForKey:@"driver_phone"] forKey:@"driver_phone"];
            [self.dataDic setValue:[Arr[0] objectForKey:@"driver_car_number"] forKey:@"driver_car_number"];
            [self.dataDic setValue:[Arr[0] objectForKey:@"driver_info_status"] forKey:@"driver_info_status"];
            [self.dataDic setValue:[Arr[0] objectForKey:@"license_type"] forKey:@"license_type"];
            [self.dataDic setValue:[Arr[0] objectForKey:@"driving_age"] forKey:@"driving_age"];
            NSData *JSONData = [[Arr[0] objectForKey:@"imglist"] dataUsingEncoding:NSUTF8StringEncoding];
            self.imageArr = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",self.imageArr);
            
            if ([[Arr[0] objectForKey:@"driver_info_status"] intValue]==2) {
                [self setWithSeccessView:[Arr[0] objectForKey:@"note"]];
                //                UIButton *but = [self.view viewWithTag:1245];
                //                [but setTitle:@"审核拒绝" forState:UIControlStateNormal];
            }
            
        }
        [_tableview reloadData];
        
    }];
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UIScreenW, UIScreenH-64) style:UITableViewStyleGrouped];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 88, UIScreenW, UIScreenH-88);
            
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        UIView *foodview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 130*MYWIDTH)];
        _tableview.tableFooterView = foodview;
        
        UIButton *foodBut = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH, 30*MYWIDTH, UIScreenW-30*MYWIDTH, 50*MYWIDTH)];
        [foodBut setBackgroundColor:UIColorFromRGB(0xCCCCCC)];
        foodBut.tag = 1245;
        foodBut.layer.cornerRadius = 8;
        [foodview addSubview:foodBut];
        if (self.status==2) {
            [foodBut setTitle:@"审核拒绝" forState:UIControlStateNormal];
        }else if (self.status==0){
            [foodBut setTitle:@"审核中" forState:UIControlStateNormal];
        }else{
            [foodBut setTitle:@"已通过【重新提交】" forState:UIControlStateNormal];
            [foodBut setBackgroundColor:MYColor];
            [foodBut addTarget:self action:@selector(foodButClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return _tableview;
    
}
- (void)foodButClick{
    jxt_showAlertTwoButton(@"提示", @"您确定需要重新提交审核吗？", @"确定", ^(NSInteger buttonIndex) {
        TiBanWuLiuSJRZViewControllerNew1 *sjrz = [[TiBanWuLiuSJRZViewControllerNew1 alloc]init];
        [self.navigationController pushViewController:sjrz animated:YES];
    }, @"取消", ^(NSInteger buttonIndex) {
        
    });
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 350;
    }if (indexPath.section == 1) {
        return 280;
    }else if (indexPath.section == 2){
        return 200;
    }
    return 240*MYWIDTH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * stringCell = @"TiBanWuLiuSjrzIngViewCellNew1";
        TiBanWuLiuSjrzIngViewCellNew1 * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameField.userInteractionEnabled = NO;
        cell.phoneField.userInteractionEnabled = NO;
        cell.nameField.layer.cornerRadius = 16.f;
        cell.nameField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        cell.nameField.layer.borderWidth = 1.0f;
        cell.nameField.layer.masksToBounds = YES;
        
        cell.phoneField.layer.cornerRadius = 16.f;
        cell.phoneField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        cell.phoneField.layer.borderWidth = 1.0f;
        cell.phoneField.layer.masksToBounds = YES;
        NSLog(@">>>>>>%@",_dataDic);
        cell.nameField.text = [self.dataDic objectForKey:@"driver_name"];
        cell.phoneField.text = [self.dataDic objectForKey:@"driver_phone"];
        if (self.imageArr.count) {
            NSLog(@">>>%@",self.imageArr);
            for (NSDictionary *dic in self.imageArr) {
                NSString *image = [NSString stringWithFormat:@"%@/%@/%@",_Environment_Domain,[dic objectForKey:@"folder"],[dic objectForKey:@"autoname"]];
                    if ([[dic objectForKey:@"driver_img_type"] intValue]==3) {
                        [cell.threeImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"tianjiashili"]];
                        
                    }
            }
        }

        return cell;
        
    }else if(indexPath.section == 1){
        static NSString * stringCell = @"WuLiuSJRZPhoneCellNew1";
        WuLiuSJRZPhoneCellNew1* cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        [cell setTiBanUpData:indexPath.section];
        if (self.imageArr.count) {
            NSLog(@">>>%@",self.imageArr);
            for (NSDictionary *dic in self.imageArr) {
                NSString *image = [NSString stringWithFormat:@"%@/%@/%@",_Environment_Domain,[dic objectForKey:@"folder"],[dic objectForKey:@"autoname"]];
                NSLog(@"%@",image);
                if (indexPath.section==1) {
                    if ([[dic objectForKey:@"driver_img_type"] intValue]==1) {
                        [cell.oneImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"tianjiashili"]];
                        
                    }else if ([[dic objectForKey:@"driver_img_type"] intValue]==2){
                        [cell.twoImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"tianjiashili"]];
                        
                    }else if ([[dic objectForKey:@"driver_img_type"] intValue]==0){
                        [cell.threeImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"tianjiashili"]];
                        
                    }
                }
                
            }
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * stringCell = @"TiBanWuLiuSJRZViewCellNewPart1";
        TiBanWuLiuSJRZViewCellNewPart1 * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.license_type.userInteractionEnabled = NO;
        cell.driving_age.userInteractionEnabled = NO;
        cell.license_type.layer.cornerRadius = 16.f;
        cell.license_type.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        cell.license_type.layer.borderWidth = 1.0f;
        cell.license_type.layer.masksToBounds = YES;
        cell.driving_age.layer.cornerRadius = 16.f;
        cell.driving_age.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        cell.driving_age.layer.borderWidth = 1.0f;
        cell.driving_age.layer.masksToBounds = YES;
        NSLog(@">>>>>>%@",_dataDic);
        cell.license_type.text = [self.dataDic objectForKey:@"license_type"];
        cell.driving_age.text = [self.dataDic objectForKey:@"driving_age"];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{//头视图
    return 10;
    
}
//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setWithSeccessView:(NSString *)note{
    
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:NO];
    [SMAlert setcontrolViewbackgroundColor:[UIColor clearColor]];
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220*MYWIDTH, 220*MYWIDTH)];
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:@"未通过"];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 85*MYWIDTH, imageview.width, 20*MYWIDTH)];
    lab.text = @"审核未通过";
    lab.font = [UIFont systemFontOfSize:14*MYWIDTH];
    lab.textColor = UIColorFromRGB(0x333333);
    lab.textAlignment = NSTextAlignmentCenter;
    [imageview addSubview:lab];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, lab.bottom+5, imageview.width, 40*MYWIDTH)];
    lab1.text = [NSString stringWithFormat:@"未通过原因:%@",note];
    lab1.numberOfLines=0;
    lab1.font = [UIFont systemFontOfSize:14*MYWIDTH];
    lab1.textColor = UIColorFromRGB(0x333333);
    lab1.textAlignment = NSTextAlignmentCenter;
    [imageview addSubview:lab1];
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(60*MYWIDTH, lab1.bottom+15*MYWIDTH, 100*MYWIDTH, 35*MYWIDTH)];
    [but setTitle:@"重新填写" forState:UIControlStateNormal];
    [but setTitleColor:MYColor forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    but.backgroundColor = [UIColor whiteColor];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    but.layer.borderColor = MYColor.CGColor;//设置边框颜色
    but.layer.borderWidth = 1;//设置边缘宽度
    [but addTarget:self action:@selector(butHideClick) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:but];
    [SMAlert showCustomView:imageview];
    
}
- (void)butHideClick{
    [SMAlert hide:NO];
    TiBanWuLiuSJRZViewControllerNew1 *sjrz = [[TiBanWuLiuSJRZViewControllerNew1 alloc]init];
    [self.navigationController pushViewController:sjrz animated:YES];
}
- (void)rightBarClick:(UIButton*)sender
{
    if (self.status==0) {
        jxt_showAlertOneButton(@"提示", @"认证正在审核中,请耐心等待", @"好的", ^(NSInteger buttonIndex) {
            
        });
    }else{
        WuLiuSJRZViewControllerNew1 *tiban = [[WuLiuSJRZViewControllerNew1 alloc]init];
        tiban.stopPush = 1;
        [self.navigationController pushViewController:tiban animated:YES];
    }
    
}
- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
