//
//  TiBanFaBuViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "TiBanFaBuViewController.h"
#import "DWTagView.h"
#import "ZhaopinDingDViewController.h"

@interface TiBanFaBuViewController ()<UITextFieldDelegate,DWTagViewDelegate, DWTagViewDataSource>

@end

@implementation TiBanFaBuViewController
{
    UITextField *_nameField;
    UITextField *_phoneField;
    UITextField *_neednumField;
    UITextField *_priceField;
    UIButton * _yujiTimeBut;
    UIButton * _jieshuTimeBut;
    
    //新的起始点
    NSMutableArray *_arr;
    DWTagView *_typeview;
    UIView * _bgView;
    NSString*_type1;
    NSString*_type2;
    NSString *_sprovince;
    NSString *_scity;
    NSString *_scounty;
    NSString *_eprovince;
    NSString *_ecity;
    NSString *_ecounty;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布招聘";
    self.view.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [self createUI];
    
    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
}
//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
    
}
- (void)createUI{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, statusbarHeight+44)];
    bgview.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgview];
    
    UIView *bgviews = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.bottom+20*MYWIDTH, UIScreenW, 330*MYWIDTH)];
    bgviews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgviews];
    
    UIImageView * shouhuoimage = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH,  11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    shouhuoimage.image = [UIImage imageNamed:@"sjj"];
    [bgviews addSubview:shouhuoimage];
    
    UILabel *titleLab9 = [[UILabel alloc]initWithFrame:CGRectMake(shouhuoimage.right+10*MYWIDTH, shouhuoimage.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab9.text = @"姓名";
    titleLab9.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab9.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab9];
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(titleLab9.right, 0, bgviews.width-15*MYWIDTH-titleLab9.right, 40*MYWIDTH)];
    _nameField.delegate = self;
    _nameField.placeholder = @"必填";
    _nameField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*MYWIDTH];
    //_nameField.textAlignment = NSTextAlignmentRight;
    _nameField.textColor = UIColorFromRGBValueValue(0x000000);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([user objectForKey:USENAME]) {
            _nameField.text = [user objectForKey:USENAME];
        }
    [bgviews addSubview:_nameField];
    [Command placeholderColor:_nameField str:_nameField.placeholder color:UIColorFromRGBValueValue(0x666666)];
    
    UIView *xian5 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, _nameField.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian5.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian5];
    
    UIImageView * phoneimage = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian5.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    phoneimage.image = [UIImage imageNamed:@"zsdh"];
    [bgviews addSubview:phoneimage];
    
    UILabel *titleLab10 = [[UILabel alloc]initWithFrame:CGRectMake(phoneimage.right+10*MYWIDTH, phoneimage.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab10.text = @"电话";
    titleLab10.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab10.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab10];
    
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(titleLab10.right, xian5.bottom, bgviews.width-15*MYWIDTH-titleLab9.right, 40*MYWIDTH)];
    _phoneField.delegate = self;
    _phoneField.placeholder = @"必填";
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*MYWIDTH];
    //_phoneField.textAlignment = NSTextAlignmentRight;
    _phoneField.textColor = UIColorFromRGBValueValue(0x000000);
        if ([user objectForKey:USERPHONE]) {
            _phoneField.text = [user objectForKey:USERPHONE];
        }
    [bgviews addSubview:_phoneField];
    [Command placeholderColor:_phoneField str:_phoneField.placeholder color:UIColorFromRGBValueValue(0x666666)];
    
    UIView *xian6 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, _phoneField.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian6.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian6];
    //起点
    UIImageView * greenimage = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian6.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    greenimage.image = [UIImage imageNamed:@"起点"];
    [bgviews addSubview:greenimage];
    
    UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(greenimage.right+10*MYWIDTH, greenimage.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab1.text = @"起点";
    titleLab1.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab1.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab1];
    
    UIImageView * youimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(bgviews.right-23*MYWIDTH, xian6.bottom + 12.5*MYWIDTH, 8*MYWIDTH, 15*MYWIDTH)];
    youimage1.image = [UIImage imageNamed:@"youjiantou"];
    [bgviews addSubview:youimage1];
    
    UIButton *qidainBut = [[UIButton alloc]initWithFrame:CGRectMake(_nameField.left, xian6.bottom, _nameField.width, 40*MYWIDTH)];
    [qidainBut setTitleColor:UIColorFromRGBValueValue(0x000000) forState:UIControlStateNormal];
    [qidainBut setTitle:@"请选择起点" forState:UIControlStateNormal];
    qidainBut.titleLabel.lineBreakMode = 0;
    qidainBut.tag = 3368;
    qidainBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [qidainBut addTarget:self action:@selector(qidainButClick:) forControlEvents:UIControlEventTouchUpInside];
    qidainBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgviews addSubview:qidainBut];
    
    
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, qidainBut.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian];
    
    //终点
    UIImageView * redimage = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    redimage.image = [UIImage imageNamed:@"终点"];
    [bgviews addSubview:redimage];
    
    UILabel *titleLab2 = [[UILabel alloc]initWithFrame:CGRectMake(redimage.right+10*MYWIDTH, redimage.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab2.text = @"终点";
    titleLab2.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab2.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab2];
    
    UIImageView * youimage2 = [[UIImageView alloc]initWithFrame:CGRectMake(bgviews.right-23*MYWIDTH, xian.bottom + 12.5*MYWIDTH, 8*MYWIDTH, 15*MYWIDTH)];
    youimage2.image = [UIImage imageNamed:@"youjiantou"];
    [bgviews addSubview:youimage2];
    
    UIButton *zhongdainBut = [[UIButton alloc]initWithFrame:CGRectMake(qidainBut.left, xian.bottom, qidainBut.width, 40*MYWIDTH)];
    [zhongdainBut setTitleColor:UIColorFromRGBValueValue(0x000000 ) forState:UIControlStateNormal];
    [zhongdainBut setTitle:@"请选择终点" forState:UIControlStateNormal];
    zhongdainBut.titleLabel.lineBreakMode = 0;
    zhongdainBut.tag = 3369;
    zhongdainBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [zhongdainBut addTarget:self action:@selector(zhongdainButClick:) forControlEvents:UIControlEventTouchUpInside];
    zhongdainBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgviews addSubview:zhongdainBut];
    
    UIView *xian2 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, zhongdainBut.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian2.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian2];
    
    UIImageView * redimage2 = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian2.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    redimage2.image = [UIImage imageNamed:@"zprs"];
    [bgviews addSubview:redimage2];
    
    UILabel *titleLab3 = [[UILabel alloc]initWithFrame:CGRectMake(redimage2.right+10*MYWIDTH, redimage2.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab3.text = @"人数";
    titleLab3.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab3.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab3];
    
    _neednumField = [[UITextField alloc]initWithFrame:CGRectMake(titleLab3.right, xian2.bottom, _nameField.width, 40*MYWIDTH)];
    _neednumField.delegate = self;
    _neednumField.placeholder = @"请输入人数";
    _neednumField.keyboardType = UIKeyboardTypeNumberPad;
    _neednumField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*MYWIDTH];
    _neednumField.textColor = UIColorFromRGBValueValue(0x000000);
    [bgviews addSubview:_neednumField];
    [Command placeholderColor:_neednumField str:_neednumField.placeholder color:UIColorFromRGBValueValue(0x666666)];
    
    UIImageView * youimage3 = [[UIImageView alloc]initWithFrame:CGRectMake(bgviews.right-23*MYWIDTH, xian2.bottom + 12.5*MYWIDTH, 8*MYWIDTH, 15*MYWIDTH)];
    youimage3.image = [UIImage imageNamed:@"youjiantou"];
    [bgviews addSubview:youimage3];
    
    //
    UIView *xian3 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, _neednumField.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian3.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian3];
    
    UIImageView * redimage3 = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian3.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    redimage3.image = [UIImage imageNamed:@"dbb"];
    [bgviews addSubview:redimage3];
    
    UILabel *titleLab4 = [[UILabel alloc]initWithFrame:CGRectMake(redimage2.right+10*MYWIDTH, redimage3.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab4.text = @"出车时间";
    titleLab4.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab4.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab4];
    
    _yujiTimeBut = [[UIButton alloc]initWithFrame:CGRectMake(titleLab4.right, xian3.bottom, _nameField.width, 40*MYWIDTH)];
    [_yujiTimeBut setTitle:@"请选择出车时间" forState:UIControlStateNormal];
    _yujiTimeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_yujiTimeBut setTitleColor:UIColorFromRGBValueValue(0x666666) forState:UIControlStateNormal];
    _yujiTimeBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [_yujiTimeBut addTarget:self action:@selector(timeButClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgviews addSubview:_yujiTimeBut];
    
    //
    UIView *xian4 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, _yujiTimeBut.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian4.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian4];
    
    UIImageView * redimage4 = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian4.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    redimage4.image = [UIImage imageNamed:@"dbb"];
    [bgviews addSubview:redimage4];
    
    UILabel *titleLab5 = [[UILabel alloc]initWithFrame:CGRectMake(redimage2.right+10*MYWIDTH, redimage4.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab5.text = @"结束时间";
    titleLab5.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab5.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab5];
    
    _jieshuTimeBut = [[UIButton alloc]initWithFrame:CGRectMake(titleLab4.right, xian4.bottom, _nameField.width, 40*MYWIDTH)];
    [_jieshuTimeBut setTitle:@"请选择结束时间" forState:UIControlStateNormal];
    _jieshuTimeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_jieshuTimeBut setTitleColor:UIColorFromRGBValueValue(0x666666) forState:UIControlStateNormal];
    _jieshuTimeBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [_jieshuTimeBut addTarget:self action:@selector(timeButClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgviews addSubview:_jieshuTimeBut];
    //
    UIView *xian7 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, _jieshuTimeBut.bottom, bgviews.width-30*MYWIDTH, 1*MYWIDTH)];
    xian7.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [bgviews addSubview:xian7];
    
    UIImageView * redimage5 = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian7.bottom + 11*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
    redimage5.image = [UIImage imageNamed:@"sjfy"];
    [bgviews addSubview:redimage5];
    
    UILabel *titleLab6 = [[UILabel alloc]initWithFrame:CGRectMake(redimage2.right+10*MYWIDTH, redimage5.top, 80*MYWIDTH, 20*MYWIDTH)];
    titleLab6.text = @"司机费用";
    titleLab6.textColor = UIColorFromRGBValueValue(0x000000);
    titleLab6.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab6];
    
    _priceField = [[UITextField alloc]initWithFrame:CGRectMake(titleLab3.right, xian7.bottom, _nameField.width-50*MYWIDTH, 40*MYWIDTH)];
    _priceField.delegate = self;
    _priceField.placeholder = @"请输入金额";
    _priceField.keyboardType = UIKeyboardTypeNumberPad;
    _priceField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*MYWIDTH];
    _priceField.textColor = UIColorFromRGBValueValue(0x000000);
    [bgviews addSubview:_priceField];
    [Command placeholderColor:_priceField str:_priceField.placeholder color:UIColorFromRGBValueValue(0x666666)];
    
    UILabel *titleLab8 = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenW-50*MYWIDTH, xian7.bottom, 50*MYWIDTH, 40*MYWIDTH)];
    titleLab8.text = @"元/人";
    titleLab8.textColor = MYColor;
    titleLab8.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:titleLab8];
    
    UIButton *newBut = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bottom-55*MYWIDTH, kScreenWidth, 55*MYWIDTH)];
    newBut.backgroundColor = MYColor;
    [newBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newBut setTitle:@"现在用车" forState:UIControlStateNormal];
    newBut.titleLabel.font = [UIFont systemFontOfSize:20*MYWIDTH];
    [newBut addTarget:self action:@selector(newButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBut];
}
- (void)newButClick{
    UIButton *qiBut = [self.view viewWithTag:3368];
    UIButton *zhongBut = [self.view viewWithTag:3369];
    if ([[Command convertNull:_nameField.text] isEqualToString:@""]) {
        jxt_showToastTitle(@"请填写姓名", 1);
        return;
    }
    if ([[Command convertNull:_phoneField.text] isEqualToString:@""]) {
        jxt_showToastTitle(@"请填写联系电话", 1);
        return;
    }
    if ([qiBut.titleLabel.text isEqualToString:@"请选择起点"]) {
        jxt_showToastTitle(@"请选择起点", 1);
        return;
    }
    if ([zhongBut.titleLabel.text isEqualToString:@"请选择终点"]){
        jxt_showToastTitle(@"请选择终点", 1);
        return;
    }
    if ([[Command convertNull:_neednumField.text] isEqualToString:@""]) {
        jxt_showToastTitle(@"请填写需求人数", 1);
        return;
    }
    if ([_yujiTimeBut.titleLabel.text isEqualToString:@"请选择出车时间"]){
        jxt_showToastTitle(@"请选择出车时间", 1);
        return;
    }
    if ([_jieshuTimeBut.titleLabel.text isEqualToString:@"请选择结束时间"]){
        jxt_showToastTitle(@"请选择结束时间", 1);
        return;
    }
    if ([[Command convertNull:_priceField.text] isEqualToString:@""]) {
        jxt_showToastTitle(@"请填写司机费用", 1);
        return;
    }
    jxt_showAlertTwoButton(@"提示", @"您确认发布信息吗？", @"取消", ^(NSInteger buttonIndex) {
        
    }, @"确定", ^(NSInteger buttonIndex) {
        NSString *XWURLStr = @"/mbtwz/driverrecruit?action=insertDriverRecruit";
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:[NSString stringWithFormat:@"%@",[Command convertNull:_nameField.text]] forKey:@"name"];
        [param setValue:[NSString stringWithFormat:@"%@",[Command convertNull:_phoneField.text]] forKey:@"phone"];
        [param setValue:[NSString stringWithFormat:@"%@",_sprovince] forKey:@"sprovince"];
        [param setValue:[NSString stringWithFormat:@"%@",_scity] forKey:@"scity"];
        [param setValue:[NSString stringWithFormat:@"%@",_scounty] forKey:@"scounty"];
        [param setValue:[NSString stringWithFormat:@"%@",_eprovince] forKey:@"eprovince"];
        [param setValue:[NSString stringWithFormat:@"%@",_ecity] forKey:@"ecity"];
        [param setValue:[NSString stringWithFormat:@"%@",_ecounty] forKey:@"ecounty"];
        [param setValue:[NSString stringWithFormat:@"%@",[Command convertNull:_neednumField.text]] forKey:@"neednum"];
        [param setValue:[NSString stringWithFormat:@"%@",_yujiTimeBut.titleLabel.text] forKey:@"stime"];
        [param setValue:[NSString stringWithFormat:@"%@",_jieshuTimeBut.titleLabel.text] forKey:@"etime"];
        [param setValue:[NSString stringWithFormat:@"%@",[Command convertNull:_priceField.text]] forKey:@"price"];
        
        NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:XWURLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==200) {
                jxt_showAlertOneButton(@"提示", @"发布成功", @"确定", ^(NSInteger buttonIndex) {
                    ZhaopinDingDViewController *dingdan = [[ZhaopinDingDViewController alloc]init];
                    dingdan.push = @"1";
                    [self.navigationController pushViewController:dingdan animated:YES];
                });
            }else{
                
                jxt_showAlertOneButton(@"提示", [dic objectForKey:@"msg"], @"确定", ^(NSInteger buttonIndex) {
                });
            }
        }];
    });
}
- (void)qidainButClick:(UIButton *)but{
    
    [_bgView removeFromSuperview];
    _bgView = nil;
    _type1 = @"1";
    _type2 = @"1";
    NSString *URLStr = @"/mbtwz/address?action=loadProvince";
    //NSString *URLStr = @"/mbtwz/route?action=queryRoute";
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"城市地址%@",_arr);
        //            NSDictionary *dic = @{@"areaname":@"全国"};
        //            [_arr insertObject:dic atIndex:0];
        if (_arr.count) {
            [self creatUITagView];
            
        }
        
    }];
    
    
}
- (void)zhongdainButClick:(UIButton *)but{

    [_bgView removeFromSuperview];
    _bgView = nil;
    _type1 = @"1";
    _type2 = @"2";
    NSString *URLStr = @"/mbtwz/address?action=loadProvince";
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"城市地址%@",_arr);
        //            NSDictionary *dic = @{@"areaname":@"全国"};
        //            [_arr insertObject:dic atIndex:0];
        if (_arr.count) {
            [self creatUITagView];
        }
        
    }];
}
- (void)creatUITagView{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, statusbarHeight+10*MYWIDTH, UIScreenW, 25)];
    titleLab.text = @"地址选择";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:19];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:titleLab];
    
    _typeview = [[DWTagView alloc] init];
    _typeview.frame = CGRectMake(0, statusbarHeight+44+5*MYWIDTH, UIScreenW, _bgView.height-statusbarHeight-94-5*MYWIDTH);
    _typeview.themeColor = [UIColor whiteColor];
    _typeview.backgroundColor = [UIColor whiteColor];
    _typeview.tagCornerRadius = 0;
    _typeview.dataSource = self;
    _typeview.delegate = self;
    _typeview.numer = 5;
    [_bgView addSubview:_typeview];
    
    UIButton *cencleBut = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenW/2-50*MYWIDTH, _bgView.height-50*MYWIDTH, 100*MYWIDTH, 35*MYWIDTH)];
    [cencleBut setTitle:@"取消" forState:UIControlStateNormal];
    [cencleBut setTitleColor:UIColorFromRGBValueValue(0x666666) forState:UIControlStateNormal];
    cencleBut.backgroundColor = UIColorFromRGB(0xCACACA);
    cencleBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [cencleBut addTarget:self action:@selector(qishicencelClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:cencleBut];
    
    
    
}
-(void)qishicencelClick{
    [_bgView removeFromSuperview];
    _bgView = nil;

}
- (NSInteger)DWnumOfItemstagView:(DWTagView *)tagView  {
    
    if (_typeview == tagView){
        return _arr.count;
    }
    return 0;
}

- (NSString *)DWtagView:(DWTagView *)tagView titleForItemAtIndex:(NSInteger)index {
    if (_typeview == tagView){
        return [_arr[index] objectForKey:@"areaname"];
    }
    return nil;
}
- (void)DWtagView:(DWTagView *)tagView heightUpdated:(CGFloat)height{
    NSLog(@">>>>>>>???>>>>>%.2f",height);
    if (_typeview == tagView){
        
    }
}

- (void)DWtagView:(DWTagView *)tagView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@">>>>>>>???>>>>>%zd",index);
    UIButton *qiBut = [self.view viewWithTag:3368];
    UIButton *zhongBut = [self.view viewWithTag:3369];
    if ([_type1 isEqualToString:@"1"]) {
        _type1 = @"2";
        if ([_type2 isEqualToString:@"1"]) {
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全国"]) {
                _sprovince = @"";
                _scity = @"";
                _scounty = @"";
                [qiBut setTitle:@"全国" forState:UIControlStateNormal];
                [_bgView removeFromSuperview];
                _bgView = nil;
            }else{
                _sprovince = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                _scity = @"";
                _scounty = @"";
                [qiBut setTitle:_sprovince forState:UIControlStateNormal];
            }
        }else if ([_type2 isEqualToString:@"2"]){
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全国"]) {
                _eprovince = @"";
                _ecity = @"";
                _ecounty = @"";
                [zhongBut setTitle:@"全国" forState:UIControlStateNormal];
                [_bgView removeFromSuperview];
                _bgView = nil;
            }else{
                _eprovince = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                _ecity = @"";
                _ecounty = @"";
                [zhongBut setTitle:_eprovince forState:UIControlStateNormal];
            }
        }
        
        NSString *URLStr = @"/mbtwz/address?action=loadCity";
        NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"provinceid\":\"%@\"}",[_arr[index] objectForKey:@"areaid"]]};
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
            //            NSDictionary *dic = @{@"areaname":@"全省"};
            //            [_arr insertObject:dic atIndex:0];
            if (_arr.count) {
                [_typeview reloadData];
            }
            
        }];
    }else if ([_type1 isEqualToString:@"2"]){
        _type1 = @"3";
        if ([_type2 isEqualToString:@"1"]) {
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全省"]) {
                _scity = @"";
                _scounty = @"";
                [qiBut setTitle:_sprovince forState:UIControlStateNormal];
                [_bgView removeFromSuperview];
                _bgView = nil;
            }else{
                _scity = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                _scounty = @"";
                [qiBut setTitle:[NSString stringWithFormat:@"%@%@",_sprovince,_scity] forState:UIControlStateNormal];
            }
        }else if ([_type2 isEqualToString:@"2"]){
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全省"]) {
                _ecity = @"";
                _ecounty = @"";
                [zhongBut setTitle:_eprovince forState:UIControlStateNormal];
                [_bgView removeFromSuperview];
                _bgView = nil;
            }else{
                _ecity = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                _ecounty = @"";
                [zhongBut setTitle:[NSString stringWithFormat:@"%@%@",_eprovince,_ecity] forState:UIControlStateNormal];
            }
        }
        
        NSString *URLStr = @"/mbtwz/address?action=loadCountry";
        NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"cityid\":\"%@\"}",[_arr[index] objectForKey:@"areaid"]]};
        
        [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
            
            //            NSDictionary *dic = @{@"areaname":@"全市"};
            //            [_arr insertObject:dic atIndex:0];
            if (_arr.count) {
                [_typeview reloadData];
            }else{
                NSDictionary *dic = @{@"areaname":@"全市"};
                [_arr insertObject:dic atIndex:0];
                [_typeview reloadData];
            }
            
        }];
        
    }else if ([_type1 isEqualToString:@"3"]){
        if ([_type2 isEqualToString:@"1"]) {
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全市"]) {
                _scounty = @"";
                [qiBut setTitle:[NSString stringWithFormat:@"%@%@",_sprovince,_scity] forState:UIControlStateNormal];
                
            
            }else{
                _scounty = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                [qiBut setTitle:[NSString stringWithFormat:@"%@%@%@",_sprovince,_scity,_scounty] forState:UIControlStateNormal];
                
                
            }
        }else if ([_type2 isEqualToString:@"2"]){
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全市"]) {
                _ecounty = @"";
                [zhongBut setTitle:[NSString stringWithFormat:@"%@%@",_eprovince,_ecity] forState:UIControlStateNormal];
                
                }else{
                    _ecounty = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                    [zhongBut setTitle:[NSString stringWithFormat:@"%@%@%@",_eprovince,_ecity,_ecounty] forState:UIControlStateNormal];
                    
                    
                }
        }
        [_bgView removeFromSuperview];
        _bgView = nil;
    }
}
- (void)timeButClick:(UIButton *)but{
    __weak typeof(self) weakSelf = self;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSMutableArray *year = [[NSMutableArray alloc]init];
    [year addObject:[NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]]];
    for (int i=0; i<29; i++) {
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
        
        [year addObject:[NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]]];
        startDate = [formatter dateFromString:[formatter stringFromDate:endDate]];
    }
    NSLog(@"%@",year);
    
    NSMutableArray *day = [[NSMutableArray alloc]init];
    NSString *dayStr;
    for (int i=0; i<24; i++) {
        dayStr = [NSString stringWithFormat:@"%d点",i];
        [day addObject:dayStr];
    }
    
    NSMutableArray *hour = [[NSMutableArray alloc]init];
    NSString *hourStr;
    for (int i=0; i<6; i++) {
        hourStr = [NSString stringWithFormat:@"%d0分",i];
        [hour addObject:hourStr];
    }
    
    //    // 自定义多列字符串
    NSArray *dataSources = @[year,day,hour];
    [BRStringPickerView showStringPickerWithTitle:@"" dataSource:dataSources defaultSelValue:weakSelf isAutoSelect:NO resultBlock:^(id selectValue) {
        
        NSString *hourstr = selectValue[1];
        hourstr = [hourstr substringToIndex:hourstr.length-1];
        if ([hourstr intValue]<10) {
            hourstr = [NSString stringWithFormat:@"0%@",hourstr];
        }else{
            hourstr = [NSString stringWithFormat:@"%@",hourstr];
        }
        
        NSString *minstr = selectValue[2];
        minstr = [minstr substringToIndex:minstr.length-1];
        
        NSString *timeStr = [NSString stringWithFormat:@"%@ %@:%@",selectValue[0],hourstr,minstr];
        
        //当前时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        if ([self dateTimeDifferenceWithStartTime:dateTime endTime:timeStr]==0) {
            jxt_showAlertTitle(@"选择的时间需大于当前时间");
        }else{
            [but setTitle:timeStr forState:UIControlStateNormal];
        }
    }];
}
/**
 * 开始到结束的时间差
 */
- (float)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    if (value<0) {
        value = 0;
    }
    return value / 3600;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
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
