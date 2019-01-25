//
//  ZhaopinDingDetailsViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "ZhaopinDingDetailsViewController.h"
#import "ZhaopinDetailsHeaderTableViewCell.h"
#import "ZhaopinDetailsTableViewCell.h"
#import "ZhaopinModel.h"
#import "SijixxModel.h"
#import "Paydetail.h"
@interface ZhaopinDingDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)ZhaopinModel * model;

@end

@implementation ZhaopinDingDetailsViewController
{
    UIButton *_newBut;
    int zhiFSJ;
    
    // 黑色的背景
    UIButton * backBtn;
    // 整个弹出框
    UIView *applyInputView;
    // TextView的输入框
    UITextField * jkTextField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"招聘订单详情";
    zhiFSJ = 0;
    _dataArr = [[NSMutableArray alloc]init];
    
    [self loadNewSearchSuyunorder];
    [self tableview];
    
    _newBut = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bottom-40*MYWIDTH, kScreenWidth, 40*MYWIDTH)];
    _newBut.backgroundColor = MYColor;
    [_newBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_newBut setTitle:@"开始" forState:UIControlStateNormal];
    _newBut.titleLabel.font = [UIFont systemFontOfSize:20*MYWIDTH];
    [_newBut addTarget:self action:@selector(newButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newBut];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoadDataBaseAliPayTrue:) name:AliPayTrue object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoadDataBaseWXPayTrue:) name:WXPayTrue object:nil];
    
}
- (void)newButClick{
    NSString *str;
    NSString *XWURLStr;
    if ([self.model.status intValue]==0) {
        str = @"您确认开始订单吗？";
        XWURLStr = @"/mbtwz/driverrecruit?action=updateDriRecrOneStart";
    }else{
        str = @"您确认结束订单吗？";
        XWURLStr = @"/mbtwz/driverrecruit?action=updateDriRecrOneEnd";
    }
    jxt_showAlertTwoButton(@"提示", str, @"取消", ^(NSInteger buttonIndex) {
        
    }, @"确定", ^(NSInteger buttonIndex) {

        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:[NSString stringWithFormat:@"%@",self.id] forKey:@"orderid"];
        NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:XWURLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==200) {
                [self loadNewSearchSuyunorder];
            }else{
                
                jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
                });
            }
        }];
    });
}
- (void)loadNewSearchSuyunorder
{
    [_dataArr removeAllObjects];
    NSString *URLStr = @"/mbtwz/driverrecruit?action=selectDriverRecrSelfDet";
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",self.id] forKey:@"orderid"];
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            self.model=[[ZhaopinModel alloc]init];
            [self.model setValuesForKeysWithDictionary:[[dic objectForKey:@"response"][0] objectForKey:@"orderdet"][0]];
            if ([self.model.status intValue]==0) {
                _newBut.hidden = NO;
                [_newBut setTitle:@"开始" forState:UIControlStateNormal];
                _tableview.frame = CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight-40*MYWIDTH);
            }else if ([self.model.status intValue]==1){
                _newBut.hidden = NO;
                [_newBut setTitle:@"结束" forState:UIControlStateNormal];
                _tableview.frame = CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight-40*MYWIDTH);

            }else{
                _newBut.hidden = YES;
                _tableview.frame = CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight);
            }
            
            NSArray *arr = [[NSArray alloc]initWithArray:[[dic objectForKey:@"response"][0] objectForKey:@"joins"]];
            if (!IsEmptyValue(arr)) {
                for (NSDictionary*dic in arr) {
                    SijixxModel *mode=[[SijixxModel alloc]init];
                    [mode setValuesForKeysWithDictionary:dic];
                    //追加数据
                    if ([self.model.status intValue]==0) {
                        [_dataArr addObject:mode];
                    }else{
                        if ([mode.status intValue]==4) {
                        }else{
                            [_dataArr addObject:mode];
                        }
                    }
                    
                }
            }
        }
//        NSLog(@"%@",array);
        
        [_tableview reloadData];
        
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return _dataArr.count;
    }
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 416;
    }
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{//头视图
    if (section==0) {
        return 0;
    }
    return 40;
}
//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        
            UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 40)];
            header.backgroundColor = UIColorFromRGB(0xEEEEEE);
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 39)];
            lab.backgroundColor = [UIColor whiteColor];
            if (_dataArr.count) {
                lab.text = @"   司机信息";
            }else{
            lab.text = @"   司机信息：暂无司机";
            }
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:17];
            [header addSubview:lab];
        
            return header;
        
        
    }
    return nil;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * stringCell = @"ZhaopinDetailsHeaderTableViewCell";
        ZhaopinDetailsHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
        }
        cell.name.text = [NSString stringWithFormat:@"%@",self.model.name];
        cell.phone.text = [NSString stringWithFormat:@"%@",self.model.phone];
        cell.qidian.text = [NSString stringWithFormat:@"%@%@%@",self.model.sprovince,self.model.scity,self.model.scounty];
        cell.zhongdian.text = [NSString stringWithFormat:@"%@%@%@",self.model.eprovince,self.model.ecity,self.model.ecounty];
        cell.neednum.text = [NSString stringWithFormat:@"%@人",self.model.neednum];
        cell.stime.text = [NSString stringWithFormat:@"%@",self.model.stime];
        cell.etime.text = [NSString stringWithFormat:@"%@",self.model.etime];
        cell.price.text = [NSString stringWithFormat:@"%@元/人",self.model.price];
        if ([self.model.status intValue]==0) {
            cell.disBut.hidden = NO;
        }else{
            cell.disBut.hidden = YES;
        }
        [cell.disBut addTarget:self action:@selector(shanchuClick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString * stringCell = @"ZhaopinDetailsTableViewCell";
    ZhaopinDetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
    }
    if (_dataArr.count) {
        SijixxModel *mode = _dataArr[indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@",mode.driver_name];
        cell.phone.text = [NSString stringWithFormat:@"%@",mode.driver_phone];
        [cell.imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_Environment_Domain,mode.headpic]] placeholderImage:nil];
        cell.Zpbut.hidden = NO;
        if ([mode.status intValue]==0) {//未选中
            [cell.Zpbut setImage:[UIImage imageNamed:@"xuanzhong_2"] forState:UIControlStateNormal];
            cell.Zpbut.tag = indexPath.row;
            [cell.Zpbut addTarget:self action:@selector(xuanzhongClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([mode.status intValue]==5){//已选中
            [cell.Zpbut setImage:[UIImage imageNamed:@"xuanzhong_1"] forState:UIControlStateNormal];
            cell.Zpbut.tag = indexPath.row;
            [cell.Zpbut addTarget:self action:@selector(xuanzhongClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([mode.status intValue]==2){//去支付
            [cell.Zpbut setImage:[UIImage imageNamed:@"fukuan"] forState:UIControlStateNormal];
            cell.Zpbut.tag = indexPath.row;
            [cell.Zpbut addTarget:self action:@selector(quzhifuClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([mode.status intValue]==3){//已支付
            [cell.Zpbut setImage:[UIImage imageNamed:@"yifukuan"] forState:UIControlStateNormal];
        }else{
            cell.Zpbut.hidden = YES;
        }

    }
    return cell;
    
}
- (void)xuanzhongClick:(UIButton *)but{
    SijixxModel *mode = _dataArr[but.tag];
    NSString *XWURLStr = @"/mbtwz/driverrecruit?action=selectDriRecrOneDri";
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",self.id] forKey:@"orderid"];
    [param setValue:[NSString stringWithFormat:@"%@",mode.id] forKey:@"seldriid"];
    if ([mode.status intValue]==0) {
        [param setValue:@"5" forKey:@"setsta"];
    }else{
        [param setValue:@"0" forKey:@"setsta"];
    }
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
    
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:XWURLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if([[dic objectForKey:@"flag"] intValue]==200) {
            [self loadNewSearchSuyunorder];
        }else{
            
            jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
            });
        }
    }];
}

- (void)shanchuClick{
    jxt_showAlertTwoButton(@"提示", @"您确认删除订单吗？", @"取消", ^(NSInteger buttonIndex) {
        
    }, @"确定", ^(NSInteger buttonIndex) {
        NSString *XWURLStr = @"/mbtwz/driverrecruit?action=deleteDriRecrOneStart";
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:[NSString stringWithFormat:@"%@",self.id] forKey:@"orderid"];
        NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:XWURLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==200) {
                jxt_showAlertOneButton(@"提示", @"订单删除成功", @"确定", ^(NSInteger buttonIndex) {
                    [self.navigationController popViewControllerAnimated:YES];
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
        
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, UIScreenW, UIScreenH-44-statusbarHeight)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
    }
    return _tableview;
    
}
- (void)quzhifuClick:(UIButton *)but{
    zhiFSJ = but.tag;
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:YES];
    [SMAlert setcontrolViewbackgroundColor:[UIColor whiteColor]];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(30*MYWIDTH, 0, kScreenWidth-60*MYWIDTH, 200*MYWIDTH)];
    bgview.backgroundColor = [UIColor whiteColor];
    
    for (int i=0; i<3; i++) {
        UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(30*MYWIDTH, 50*MYWIDTH+50*MYWIDTH*i, bgview.width-60*MYWIDTH, 1)];
        xian.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
        [bgview addSubview:xian];
    }
    NSArray *imageArr = @[@"单选_选中",@"单选_未选中",@"单选_未选中",@"单选_未选中"];
    for (int i=0; i<imageArr.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(45*MYWIDTH, 15*MYWIDTH+i*50*MYWIDTH, 20*MYWIDTH, 20*MYWIDTH)];
        imageview.image = [UIImage imageNamed:imageArr[i]];
        [bgview addSubview:imageview];
    }
    NSArray *imageArr1 = @[@"未标题-5.1",@"未标题-5.2",@"未标题-5.3",@"线下支付"];
    for (int i=0; i<imageArr.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(bgview.width/3, 10*MYWIDTH+i*50*MYWIDTH, 30*MYWIDTH, 30*MYWIDTH)];
        imageview.image = [UIImage imageNamed:imageArr1[i]];
        [bgview addSubview:imageview];
    }
    NSArray *titleArr = @[@"支付宝支付",@"微信支付",@"余额支付",@"线下支付"];
    for (int i=0; i<titleArr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(bgview.width/2-10, 10*MYWIDTH+i*50*MYWIDTH, 200, 30*MYWIDTH)];
        lab.text = titleArr[i];
        lab.font = [UIFont systemFontOfSize:15*MYWIDTH];
        lab.textColor = UIColorFromRGBValueValue(0x333333);
        [bgview addSubview:lab];
    }
    for (int i=0; i<4; i++) {
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, i*50*MYWIDTH, bgview.width, 50*MYWIDTH)];
        but.tag = 550+i;
        [but addTarget:self action:@selector(zhifuButClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:but];
    }
    [SMAlert showCustomView:bgview];
    [SMAlert hideCompletion:^{
        
    }];
}
- (void)zhifuButClicked:(UIButton *)button{
    [SMAlert hide:NO];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    SijixxModel *mode = _dataArr[zhiFSJ];
    if (button.tag == 550) {//支付宝
        jxt_showAlertTwoButton(@"提示", @"您确定使用支付宝支付吗", @"取消", ^(NSInteger buttonIndex) {
            
        }, @"确定", ^(NSInteger buttonIndex) {
            jxt_showAlertOneButton(@"提示", @"正在开发中",@"确定" , ^(NSInteger buttonIndex) {
                
            });
              //[Paydetail zhiFuBaoname:@"货滴物联" titile:@"货滴司机招聘" price:self.model.price orderId:[NSString stringWithFormat:@"%@_%@",mode.uuid,[user objectForKey:USERID]] notice:@"3"];
            
        });
        
        
    }else if (button.tag == 551){//微信支付
        jxt_showAlertTwoButton(@"提示", @"您确定使用微信支付吗", @"取消", ^(NSInteger buttonIndex) {
            
        }, @"确定", ^(NSInteger buttonIndex) {
            jxt_showAlertOneButton(@"提示", @"正在开发中",@"确定" , ^(NSInteger buttonIndex) {
                
            });
              //[Paydetail wxname:@"货滴物联" titile:@"货滴司机招聘" price:self.model.price orderId:[NSString stringWithFormat:@"%@_%@",mode.uuid,[user objectForKey:USERID]] notice:@"3"];
            
        });
        
        
    }else if (button.tag == 552){//余额支付
        jxt_showAlertTwoButton(@"提示", @"您确定使用余额支付吗", @"取消", ^(NSInteger buttonIndex) {
            
        }, @"确定", ^(NSInteger buttonIndex) {
            //验证密码
            NSString *passwordURLStr = @"/mbtwz/logisticssendwz?action=checkZhiFuPassword";
            [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:passwordURLStr Parameters:nil FinishedLogin:^(id responseObject) {
                
                NSString* str = [[NSString alloc]initWithData:responseObject encoding:kCFStringEncodingUTF8];
                if ([str rangeOfString:@"false"].location!=NSNotFound) {
                    jxt_showAlertTwoButton(@"温馨提示", @"请到：个人中心-设置-安全中心-设置支付密码中进行设置", @"确定", ^(NSInteger buttonIndex) {
                        ReplacePayPswVC* vc = [[ReplacePayPswVC alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }, @"取消", ^(NSInteger buttonIndex) {
                        
                    });
                }else{
                    [self createUI];
                    [self pushApplyCase];
                }
            }];
        });
    }else if (button.tag == 553){//线下支付
        jxt_showAlertTwoButton(@"提示", @"您确定使用线下支付吗", @"取消", ^(NSInteger buttonIndex) {
            
        }, @"确定", ^(NSInteger buttonIndex) {
            
           
            NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"driid\":\"%@\"}",mode.id]};
            
            NSLog(@"%@",params);
            [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:@"/mbtwz/driverrecruit?action=driRecrUndlinePay" Parameters:params FinishedLogin:^(id responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
                if([[dic objectForKey:@"flag"] intValue]==200) {
                    [self paySuccess];
                }else{
                    
                    jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
                    });
                }
                [self loadNewSearchSuyunorder];
            }];
        });
    }
    
}
#pragma mark 弹出申请框
-(void)pushApplyCase{
    
    [UIView animateWithDuration:0.36f animations:^{
        
        backBtn.alpha = 0.48;
        applyInputView.alpha = 1;
        
    }completion:^(BOOL finished) {
        
    }];
}
#pragma mark UI的设置
-(void)createUI{
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
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20*MYWIDTH, 10*MYWIDTH, UIScreenW-40, 18*MYWIDTH)];
    title.text = @"余额支付";
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
    jkTextField.placeholder = @"输入支付密码";
    jkTextField.secureTextEntry = YES;
    jkTextField.textAlignment = NSTextAlignmentCenter;
    jkTextField.font = [UIFont systemFontOfSize:14.0f*MYWIDTH];
    [tfLabel addSubview:jkTextField];
    [Command placeholderColor:jkTextField str:jkTextField.placeholder color:UIColorFromRGBValueValue(0x333333)];
    
    CGFloat btnWidth = (applyInputView.width-60*MYWIDTH)/2;
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(20*MYWIDTH, tfLabel.bottom+25*MYWIDTH, btnWidth, 35*MYWIDTH)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16.f*MYWIDTH];
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark 取消
-(void)canle{
    [applyInputView removeFromSuperview];
    [backBtn removeFromSuperview];
}

#pragma mark 确定
-(void)sure{
    [jkTextField resignFirstResponder];
    
    if ([jkTextField.text isEqualToString:@""]) {
        jxt_showToastTitle(@"密码不能为空", 1);
    }else{
        SijixxModel *mode = _dataArr[zhiFSJ];
        
        NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"insertpwd\":\"%@\",\"driid\":\"%@\"}",jkTextField.text,mode.id]};
        
        NSLog(@"%@",params);
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:@"/mbtwz/driverrecruit?action=driRecrYePay" Parameters:params FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==200) {
                [SMAlert hide:NO];
                [jkTextField resignFirstResponder];
                [backBtn removeFromSuperview];
                [applyInputView removeFromSuperview];
                [self paySuccess];
            }else{
                
                jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
                });
            }
            [self loadNewSearchSuyunorder];
        }];
        
    }
}
- (void)paySuccess{
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:YES];
    [SMAlert setcontrolViewbackgroundColor:[UIColor clearColor]];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230*MYWIDTH, 200*MYWIDTH)];
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:@"订单提交成功"];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, imageview.height/2, imageview.width, 30*MYWIDTH)];
    lab.text = @"订单支付成功";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = UIColorFromRGB(0x333333);
    [imageview addSubview:lab];
    
//    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(0, lab.bottom+5*MYWIDTH, imageview.width, 30*MYWIDTH)];
//    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"前去开始订单"];
//    [tncString addAttribute:NSUnderlineStyleAttributeName
//                      value:@(NSUnderlineStyleSingle)
//                      range:(NSRange){0,[tncString length]}];
//    //此时如果设置字体颜色要这样
//    [tncString addAttribute:NSForegroundColorAttributeName value:MYColor  range:NSMakeRange(0,[tncString length])];
//
//    //设置下划线颜色...
//    [tncString addAttribute:NSUnderlineColorAttributeName value:MYColor range:(NSRange){0,[tncString length]}];
//    [but setAttributedTitle:tncString forState:UIControlStateNormal];
//    but.titleLabel.font = [UIFont systemFontOfSize:14];
//    [but addTarget:self action:@selector(fahuodanButClicked) forControlEvents:UIControlEventTouchUpInside];
//    [imageview addSubview:but];
    
    [SMAlert showCustomView:imageview];
    [SMAlert hideCompletion:^{
        
//        TongChKuaiYOrderDetail *tongVc = [[TongChKuaiYOrderDetail alloc]init];
//        tongVc.orderStr = self.model.orderno;
//        tongVc.orderid = self.model.id;
//        [self.navigationController pushViewController:tongVc animated:YES];
        
    }];
}
- (void)getLoadDataBaseAliPayTrue:(NSNotification *)notice{
    NSLog(@"支付结果》》》》%@",notice.userInfo);
    /*
     {
     result = "{"alipay_trade_app_pay_response":{"code":"10000","msg":"Success","app_id":"2016020201135575","auth_app_id":"2016020201135575","charset":"utf-8","timestamp":"2017-09-11 12:07:04","total_amount":"0.01","trade_no":"2017091121001004730285476459","seller_id":"2088911120626880","out_trade_no":"a259a638a2494216bdad-62"},"sign":"avQ9kA4WQR8XqkDbFUPtNgNtSDV79dKGYo4xfxNClRdXolGr5zvDaRS+3zpECgGK9bQIP1/kkTb/T27S3F7JUxd65aMkMarWECIlu31KYqUBso1HQoIInEh+zU/UzWlQWDQgqlI7bXbAmiSnR5mpXWhiT4k0TrqXoa8UH3WZwLI=","sign_type":"RSA"}";
     resultStatus = "9000";
     memo = ""
     }
     
     {
     result = "";
     resultStatus = "6001";
     memo = "用户中途取消"
     }
     */
    if (notice.userInfo) {
        
        if ([[notice.userInfo objectForKey:@"resultStatus"] intValue] == 9000 ) {
            [SMAlert hide:NO];
            [self paySuccess];
            [self loadNewSearchSuyunorder];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果" message:[notice.userInfo objectForKey:@"memo"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}
- (void)getLoadDataBaseWXPayTrue:(NSNotification *)notice{
    [SMAlert hide:NO];
    [self paySuccess];
    [self loadNewSearchSuyunorder];
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
