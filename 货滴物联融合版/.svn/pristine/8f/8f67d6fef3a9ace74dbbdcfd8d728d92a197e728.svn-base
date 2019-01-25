//
//  LineFaBuViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/9/25.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "LineFaBuViewController1.h"
#import "DWTagView1.h"

@interface LineFaBuViewController1 ()<DWTagViewDelegate, DWTagViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_arr;
    DWTagView1 *_typeview;
    UIView * _bgView;
    NSString*_type1;
    NSString*_type2;
    NSString *_sprovince;
    NSString *_scity;
    NSString *_scounty;
    NSString *_eprovince;
    NSString *_ecity;
    NSString *_ecounty;
    NSString *_cartypenames;
    
    NSArray *_carTypeArr;
    UIView *_alicteView;
    UITextField * _use_car_typeField;
    UIButton *_use_car_typeBut;
    NSString *_use_car_typeStr;
    NSArray *_carLengthArr;
    NSString *_carlengthnames;
}
@end

@implementation LineFaBuViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 25)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 25)];
    titleLab.text = @"订阅货源路线";
    titleLab.textColor = [UIColor redColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLab];
    self.navigationItem.titleView = titleView;
    _type1 = @"1";
    _type2 = @"1";
    _sprovince = @"";
    _scity =  @"";
    _scounty = @"";
    _eprovince = @"";
    _ecity = @"";
    _ecounty = @"";
    _cartypenames = @"";
    _use_car_typeStr = @"2";
    _carlengthnames = @"";
    _arr = [[NSMutableArray alloc]init];
    [self loadNewsearchKuaiyunCartype];
    [self loadNewsearchVehicleLength];
    [self creatUI];
}
- (void)creatUI{
    UIView* sView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, statusbarHeight+44, kScreenWidth, UIScreenH-statusbarHeight-44)];
    sView.backgroundColor = UIColorFromRGB(0xEEEEEE);;
    [self.view addSubview:sView];
    
    NSArray* titleArray = @[@"出发地",@"目的地",@"车长车型"];
    NSArray* pleaceArray =@[@"请选择",@"请选择",@"不限"];
    for (int i=0; i < 3; i++) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, 20*MYWIDTH+i*65*MYWIDTH, kScreenWidth-30*MYWIDTH, 45*MYWIDTH)];
        view.backgroundColor = [UIColor whiteColor];
        [sView addSubview:view];
        
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*MYWIDTH, 0, 80*MYWIDTH, 45*MYWIDTH)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [view addSubview:titleLabel];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(titleLabel.right, 0, view.width - titleLabel.right-27, 45*MYWIDTH);
        btn.tag = 3000+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitle:pleaceArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView* rightimg = [[UIImageView alloc]initWithFrame:CGRectMake(btn.right, 45*MYWIDTH/2-5, 18, 10)];
        rightimg.image = [UIImage imageNamed:@"形状-2"];
        [view addSubview:rightimg];
    }
    
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(0, kScreenHeight - 50*MYWIDTH, kScreenWidth, 50*MYWIDTH);
    [nextBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"添 加" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextClick:(UIButton*)sender{
    _use_car_typeStr = [NSString stringWithFormat:@"%d",[_use_car_typeStr intValue]+1];
    if ([_use_car_typeStr isEqualToString:@"3"]) {
        _use_car_typeStr = @"0";
    }
    
//    if ([_scity isEqualToString:@""]){
//        //jxt_showToastTitle(@"请选择出发地省和市", 1);
//        jxt_showAlertOneButton(@"提示", @"请选择出发地省和市", @"确定", ^(NSInteger buttonIndex) {
//            
//        });
//        return;
//    }
//    if ([_ecity isEqualToString:@""]){
//        //jxt_showToastTitle(@"请选择目的地省和市", 1);
//        jxt_showAlertOneButton(@"提示", @"请选择目的地省和市", @"确定", ^(NSInteger buttonIndex) {
//            
//        });
//        return;
//    }
    
    //
    NSString *URLStr = @"/mbtwz/route?action=addRouteOne";
    NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"eaddress\":\"\",\"elongitude\":\"\",\"elatitude\":\"\",\"saddress\":\"\",\"slongitude\":\"\",\"slatitude\":\"\",\"sprovince\":\"%@\",\"scity\":\"%@\",\"scounty\":\"%@\",\"eprovince\":\"%@\",\"ecity\":\"%@\",\"ecounty\":\"%@\",\"car_types\":\"%@\",\"car_length\":\"%@\",\"usecar_type\":\"%@\"}",_sprovince,_scity,_scounty,_eprovince,_ecity,_ecounty,_cartypenames,_carlengthnames,_use_car_typeStr]};
    NSLog(@"参数==%@",params);
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
        
        NSDictionary* diction = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"zulin%@",diction);
        if ([[diction objectForKey:@"flag"] intValue]==200) {
            jxt_showToastTitle(@"添加成功", 1);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            jxt_showToastTitle([diction objectForKey:@"msg"], 1);
        }
        
        
        
    }];
}
- (void)btnClick:(UIButton*)sender{
    if (sender.tag ==3000) {
        [_bgView removeFromSuperview];
        _bgView = nil;
        _type1 = @"1";
        _type2 = @"1";
        NSString *URLStr = @"/mbtwz/address?action=loadProvince";
        //NSString *URLStr = @"/mbtwz/route?action=queryRoute";
        [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
//            NSDictionary *dic = @{@"areaname":@"全国"};
//            [_arr insertObject:dic atIndex:0];
            if (_arr.count) {
                [self creatUITagView];
                
            }
            
        }];
    }else if (sender.tag ==3001){
        [_bgView removeFromSuperview];
        _bgView = nil;
        _type1 = @"1";
        _type2 = @"2";
        NSString *URLStr = @"/mbtwz/address?action=loadProvince";
        [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
//            NSDictionary *dic = @{@"areaname":@"全国"};
//            [_arr insertObject:dic atIndex:0];
            if (_arr.count) {
                [self creatUITagView];
            }
            
        }];
    }else if (sender.tag ==3002){
        [_alicteView removeFromSuperview];
        _alicteView = nil;
        [self typeCarButClick];
    }
}
- (void)creatUITagView{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
    _typeview = [[DWTagView1 alloc] init];
    _typeview.frame = CGRectMake(0, statusbarHeight+44, UIScreenW, _bgView.height-statusbarHeight-94);
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
    [cencleBut addTarget:self action:@selector(cencelClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:cencleBut];
}
-(void)cencelClick{
    [_bgView removeFromSuperview];
    _bgView = nil;
    [_alicteView removeFromSuperview];
    _alicteView = nil;
}
- (NSInteger)DWnumOfItemstagView:(DWTagView1 *)tagView  {
    
    if (_typeview == tagView){
        return _arr.count;
    }
    return 0;
}

- (NSString *)DWTagView1:(DWTagView1 *)tagView titleForItemAtIndex:(NSInteger)index {
    if (_typeview == tagView){
        return [_arr[index] objectForKey:@"areaname"];
    }
    return nil;
}
- (void)DWTagView1:(DWTagView1 *)tagView heightUpdated:(CGFloat)height{
    NSLog(@">>>>>>>???>>>>>%.2f",height);
    if (_typeview == tagView){
        
    }
}

- (void)DWTagView1:(DWTagView1 *)tagView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@">>>>>>>???>>>>>%zd",index);
    UIButton *qiBut = [self.view viewWithTag:3000];
    UIButton *zhongBut = [self.view viewWithTag:3001];
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
                [qiBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
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
                [zhongBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
            }
        }
        
        NSString *URLStr = @"/mbtwz/address?action=loadCity";
        NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"provinceid\":\"%@\"}",[_arr[index] objectForKey:@"areaid"]]};
        
        [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
            NSDictionary *dic = @{@"areaname":@"全省"};
            [_arr insertObject:dic atIndex:0];
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
                [qiBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
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
                [zhongBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
            }
        }
        
        NSString *URLStr = @"/mbtwz/address?action=loadCountry";
        NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"cityid\":\"%@\"}",[_arr[index] objectForKey:@"areaid"]]};
        
        [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
            _arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"城市地址%@",_arr);
            NSDictionary *dic = @{@"areaname":@"全市"};
            [_arr insertObject:dic atIndex:0];
            if (_arr.count) {
                [_typeview reloadData];
            }
            
        }];
    }else if ([_type1 isEqualToString:@"3"]){
        if ([_type2 isEqualToString:@"1"]) {
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全市"]) {
                _scounty = @"";
                [qiBut setTitle:_scity forState:UIControlStateNormal];
            }else{
                _scounty = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                [qiBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
            }
        }else if ([_type2 isEqualToString:@"2"]){
            if ([[_arr[index] objectForKey:@"areaname"] isEqualToString:@"全市"]) {
                _ecounty = @"";
                [zhongBut setTitle:_ecity forState:UIControlStateNormal];
            }else{
                _ecounty = [NSString stringWithFormat:@"%@",[_arr[index] objectForKey:@"areaname"]];
                [zhongBut setTitle:[_arr[index] objectForKey:@"areaname"] forState:UIControlStateNormal];
            }
        }
        [_bgView removeFromSuperview];
        _bgView = nil;
    }
}
//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [_use_car_typeField resignFirstResponder];
    
}
- (void)typeCarButClick{
    
    _alicteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH)];
    _alicteView.backgroundColor = [UIColor whiteColor];
    _alicteView.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_alicteView];
    
    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [_alicteView addGestureRecognizer:tap1];
    
    UIScrollView *baiBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, statusbarHeight, kScreenWidth, _alicteView.height-statusbarHeight)];
    baiBgView.backgroundColor = [UIColor whiteColor];
    baiBgView.showsVerticalScrollIndicator = NO;
    baiBgView.showsHorizontalScrollIndicator = NO;
    baiBgView.bounces = NO;
    [_alicteView addSubview:baiBgView];
    
    UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(15*MYWIDTH, 30*MYWIDTH, kScreenWidth, 25*MYWIDTH)];
    titleLab1.text = @"用车类型";
    titleLab1.textColor = [UIColor blackColor];
    titleLab1.textAlignment = NSTextAlignmentLeft;
    titleLab1.font = [UIFont boldSystemFontOfSize:15*MYWIDTH];
    [baiBgView addSubview:titleLab1];
    
    float w = (kScreenWidth-75*MYWIDTH)/4;
    float dowe1 = 0;
    NSArray *arr1 = @[@"不限类型",@"整车",@"零担"];
    for (int i=0; i<arr1.count; i++) {
        UIButton *But = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH+i%4*(w+15*MYWIDTH), titleLab1.bottom + 5*MYWIDTH+i/4*40*MYWIDTH, w, 35*MYWIDTH)];
        [But setTitle:arr1[i] forState:UIControlStateNormal];
        [But setTitle:arr1[i] forState:UIControlStateSelected];
        [But setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [But setBackgroundColor:[UIColor whiteColor]];
        But.titleLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        But.layer.cornerRadius = 3.0;
        But.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;//设置边框颜色
        But.layer.borderWidth = 0.5f;//设置边框颜色
        But.tag = 3155+i;
        [But addTarget:self action:@selector(use_car_typeClick:) forControlEvents:UIControlEventTouchUpInside];
        [baiBgView addSubview:But];
        if (i==0) {
            [But setBackgroundColor:MYColor];
            But.layer.borderColor = MYColor.CGColor;
            [But setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            _use_car_typeBut = But;
        }
        if (i==arr1.count-1) {
            dowe1 = But.bottom;
        }
    }
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, dowe1+10*MYWIDTH, kScreenWidth, 5*MYWIDTH)];
    xian.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [baiBgView addSubview:xian];
    
    UILabel *titleLab2 = [[UILabel alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian.bottom+15*MYWIDTH, kScreenWidth, 25*MYWIDTH)];
    titleLab2.text = @"车长";
    titleLab2.textColor = [UIColor blackColor];
    titleLab2.textAlignment = NSTextAlignmentLeft;
    titleLab2.font = [UIFont boldSystemFontOfSize:15*MYWIDTH];
    [baiBgView addSubview:titleLab2];
    
    UILabel *titleLab21 = [[UILabel alloc]initWithFrame:CGRectMake(40*MYWIDTH, 3*MYWIDTH, kScreenWidth, 20*MYWIDTH)];
    titleLab21.text = @"(*可多选)";
    titleLab21.textColor = UIColorFromRGB(0x666666);
    titleLab21.textAlignment = NSTextAlignmentLeft;
    titleLab21.font = [UIFont systemFontOfSize:12*MYWIDTH];
    [titleLab2 addSubview:titleLab21];
    
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _carLengthArr) {
        [arr2 addObject:[dic objectForKey:@"lengthname"]];
    }
    float dowe2 = 0;
    for (int i=0; i<arr2.count; i++) {
        UIButton *But = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH+i%4*(w+15*MYWIDTH), titleLab2.bottom + 10*MYWIDTH+i/4*45*MYWIDTH, w, 35*MYWIDTH)];
        [But setTitle:[NSString stringWithFormat:@"%@",arr2[i]] forState:UIControlStateNormal];
        [But setTitle:[NSString stringWithFormat:@"%@",arr2[i]] forState:UIControlStateSelected];
        [But setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [But setBackgroundColor:[UIColor whiteColor]];
        But.titleLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        But.layer.cornerRadius = 3.0;
        But.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;//设置边框颜色
        But.layer.borderWidth = 0.5f;//设置边框颜色
        But.tag = 2155+i;
        [But addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
        [baiBgView addSubview:But];
        
        if (i==arr2.count-1) {
            dowe2 = But.bottom;
        }
    }
    
    _use_car_typeField = [[UITextField alloc]initWithFrame:CGRectMake(15*MYWIDTH, dowe2+10*MYWIDTH, 200*MYWIDTH, 35*MYWIDTH)];
    _use_car_typeField.delegate = self;
    _use_car_typeField.placeholder = @"请输入其他车长";
    _use_car_typeField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14*MYWIDTH];
    _use_car_typeField.textAlignment = NSTextAlignmentLeft;
    _use_car_typeField.returnKeyType = UIReturnKeyDone;
    _use_car_typeField.keyboardType = UIKeyboardTypeDecimalPad;
    _use_car_typeField.textColor = UIColorFromRGBValueValue(0x000000);
    _use_car_typeField.layer.cornerRadius = 3.0;
    _use_car_typeField.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;//设置边框颜色
    _use_car_typeField.layer.borderWidth = 0.5f;//设置边框颜色
    _use_car_typeField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    _use_car_typeField.leftViewMode = UITextFieldViewModeAlways;
    [baiBgView addSubview:_use_car_typeField];
    [Command placeholderColor:_use_car_typeField str:_use_car_typeField.placeholder color:UIColorFromRGBValueValue(0x666666)];
    
    UIView *xian1 = [[UIView alloc]initWithFrame:CGRectMake(0, _use_car_typeField.bottom+10*MYWIDTH, kScreenWidth, 5*MYWIDTH)];
    xian1.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
    [baiBgView addSubview:xian1];
    
    UILabel *titleLab3 = [[UILabel alloc]initWithFrame:CGRectMake(15*MYWIDTH, xian1.bottom+15*MYWIDTH, kScreenWidth, 25*MYWIDTH)];
    titleLab3.text = @"选择车型";
    titleLab3.textColor = [UIColor blackColor];
    titleLab3.textAlignment = NSTextAlignmentLeft;
    titleLab3.font = [UIFont boldSystemFontOfSize:15*MYWIDTH];
    [baiBgView addSubview:titleLab3];
    
    UILabel *titleLab31 = [[UILabel alloc]initWithFrame:CGRectMake(70*MYWIDTH, 3*MYWIDTH, kScreenWidth, 20*MYWIDTH)];
    titleLab31.text = @"(*车型可多选)";
    titleLab31.textColor = UIColorFromRGB(0x666666);
    titleLab31.textAlignment = NSTextAlignmentLeft;
    titleLab31.font = [UIFont systemFontOfSize:12*MYWIDTH];
    [titleLab3 addSubview:titleLab31];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _carTypeArr) {
        [arr addObject:[dic objectForKey:@"cartypename"]];
    }
    
    
    float dowe = 0;
    for (int i=0; i<arr.count; i++) {
        UIButton *But = [[UIButton alloc]initWithFrame:CGRectMake(15*MYWIDTH+i%4*(w+15*MYWIDTH), titleLab3.bottom + 10*MYWIDTH+i/4*45*MYWIDTH, w, 35*MYWIDTH)];
        [But setTitle:arr[i] forState:UIControlStateNormal];
        [But setTitle:arr[i] forState:UIControlStateSelected];
        [But setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [But setBackgroundColor:[UIColor whiteColor]];
        But.titleLabel.font = [UIFont systemFontOfSize:15*MYWIDTH];
        But.layer.cornerRadius = 3.0;
        But.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;//设置边框颜色
        But.layer.borderWidth = 0.5f;//设置边框颜色
        But.tag = 1155+i;
        [But addTarget:self action:@selector(ButClick:) forControlEvents:UIControlEventTouchUpInside];
        [baiBgView addSubview:But];
        
        if (i==arr.count-1) {
            dowe = But.bottom;
        }
    }
    
    UIButton *cencleBut = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenW/2-107.5*MYWIDTH, dowe+20*MYWIDTH, 100*MYWIDTH, 35*MYWIDTH)];
    [cencleBut setTitle:@"取消" forState:UIControlStateNormal];
    [cencleBut setTitleColor:UIColorFromRGBValueValue(0x666666) forState:UIControlStateNormal];
    cencleBut.backgroundColor = UIColorFromRGB(0xCACACA);
    cencleBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [cencleBut addTarget:self action:@selector(cencelClick) forControlEvents:UIControlEventTouchUpInside];
    [baiBgView addSubview:cencleBut];
    
    UIButton *quedingBut = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenW/2+7.5*MYWIDTH, dowe+20*MYWIDTH, 100*MYWIDTH, 35*MYWIDTH)];
    [quedingBut setTitle:@"确定" forState:UIControlStateNormal];
    [quedingBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    quedingBut.backgroundColor = MYColor;
    quedingBut.titleLabel.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [quedingBut addTarget:self action:@selector(cartypeClick) forControlEvents:UIControlEventTouchUpInside];
    [baiBgView addSubview:quedingBut];
    
    baiBgView.contentSize = CGSizeMake(kScreenWidth, cencleBut.bottom+20*MYWIDTH);
    
}
- (void)use_car_typeClick:(UIButton *)but{
    
    NSArray *arr1 = @[@"整车",@"零担",@"不限类型"];
    for (int i=0; i<arr1.count; i++) {
        NSString *str = arr1[i];
        if ([but.titleLabel.text isEqualToString:str]) {
            _use_car_typeStr = [NSString stringWithFormat:@"%d",i];
        }
    }
    [_use_car_typeBut setBackgroundColor:[UIColor whiteColor]];
    _use_car_typeBut.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;
    [_use_car_typeBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [but setBackgroundColor:MYColor];
    but.layer.borderColor = MYColor.CGColor;
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _use_car_typeBut = but;
}
- (void)ButClick:(UIButton *)but{
    but.selected = !but.selected;
    if (but.selected) {
        [but setBackgroundColor:MYColor];
        but.layer.borderColor = MYColor.CGColor;
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }else{
        [but setBackgroundColor:[UIColor whiteColor]];
        but.layer.borderColor = UIColorFromRGBValueValue(0x888888).CGColor;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    }
}
- (void)cartypeClick{
    UIButton *typecarBut = [self.view viewWithTag:3002];
    
    NSArray *arr1 = @[@"整车",@"零担",@"不限类型"];
    
    NSMutableString *_carTypeStr;
    for (int i=0 ; i<_carTypeArr.count; i++) {
        UIButton *but = [_alicteView viewWithTag:1155+i];
        if (but.selected) {
            _carTypeStr = [NSMutableString stringWithFormat:@"%@,%@",_carTypeStr,[_carTypeArr[i] objectForKey:@"cartypename"]];
        }
    }
    [_carTypeStr deleteCharactersInRange:NSMakeRange(0, 7)];
    
    NSMutableString *_carlengthStr;
    for (int i=0 ; i<_carLengthArr.count; i++) {
        UIButton *but = [_alicteView viewWithTag:2155+i];
        if (but.selected) {
            _carlengthStr = [NSMutableString stringWithFormat:@"%@,%@",_carlengthStr,[_carLengthArr[i] objectForKey:@"lengthname"]];
        }
    }
    if(![_use_car_typeField.text isEqualToString:@""]){
        _carlengthStr = [NSMutableString stringWithFormat:@"%@,%@",_carlengthStr,_use_car_typeField.text];
    }
    [_carlengthStr deleteCharactersInRange:NSMakeRange(0, 7)];
    
    if (_carTypeStr.length>0) {
        _cartypenames = _carTypeStr;
        if (_carlengthStr.length>0) {
            _carlengthnames = _carlengthStr;
            if ([_use_car_typeStr isEqualToString:@"2"]) {
                [typecarBut setTitle:[NSString stringWithFormat:@"%@,%@",_carlengthStr,_carTypeStr] forState:UIControlStateNormal];
            }else{
                int i = [_use_car_typeStr intValue];
                [typecarBut setTitle:[NSString stringWithFormat:@"%@,%@,%@",arr1[i],_carlengthStr,_carTypeStr] forState:UIControlStateNormal];
            }
        }else{
            _carlengthnames = @"";
            if ([_use_car_typeStr isEqualToString:@"2"]) {
                [typecarBut setTitle:[NSString stringWithFormat:@"%@",_carTypeStr] forState:UIControlStateNormal];
            }else{
                int i = [_use_car_typeStr intValue];
                [typecarBut setTitle:[NSString stringWithFormat:@"%@,%@",arr1[i],_carTypeStr] forState:UIControlStateNormal];
            }
        }
    }else{
        _cartypenames = @"";
        if (_carlengthStr.length>0) {
            _carlengthnames = _carlengthStr;
            if ([_use_car_typeStr isEqualToString:@"2"]) {
                [typecarBut setTitle:[NSString stringWithFormat:@"%@",_carlengthStr] forState:UIControlStateNormal];
            }else{
                int i = [_use_car_typeStr intValue];
                [typecarBut setTitle:[NSString stringWithFormat:@"%@,%@",arr1[i],_carlengthStr] forState:UIControlStateNormal];
            }
        }else{
            _carlengthnames = @"";
            if ([_use_car_typeStr isEqualToString:@"2"]) {
                [typecarBut setTitle:@"不限" forState:UIControlStateNormal];
            }else{
                int i = [_use_car_typeStr intValue];
                [typecarBut setTitle:[NSString stringWithFormat:@"%@",arr1[i]] forState:UIControlStateNormal];
            }
        }
    }
    [_alicteView removeFromSuperview];
    _alicteView = nil;
}

- (void)loadNewsearchKuaiyunCartype
{
    //快运 车型选择 查询接口
    NSString *URLStr = @"/mbtwz/logisticssendwz?action=searchKuaiyunCartype";
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        _carTypeArr = [[NSArray alloc]init];
        _carTypeArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    }];
}
- (void)loadNewsearchVehicleLength
{
    //快运 车长 查询接口
    NSString *URLStr = @"/mbtwz/logisticssendwz?action=searchVehicleLength";
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            _carLengthArr = [[NSArray alloc]initWithArray:[dic objectForKey:@"response"]];
        }
        
    }];
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
