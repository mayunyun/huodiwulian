//
//  LineSetViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/9/25.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "LineSetViewController1.h"
#import "MyLineViewController1.h"
@interface LineSetViewController1 ()

@end

@implementation LineSetViewController1
{
    UILabel *_tishiLab;
    UISwitch *_mainSwitch;
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
    
    _tishiLab = [[UILabel alloc]initWithFrame:CGRectMake(15*MYWIDTH, statusbarHeight+44, 200*MYWIDTH, 50)];
    if ([self.remind intValue]==1) {
        _tishiLab.text = @"货源声音提醒（已开启）";
    }else{
        _tishiLab.text = @"货源声音提醒（已关闭）";
    }
    _tishiLab.textColor = [UIColor blackColor];
    _tishiLab.font = [UIFont systemFontOfSize:15*MYWIDTH];
    [self.view addSubview:_tishiLab];
    
    _mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(UIScreenW-70, statusbarHeight+54, 0, 0)];
    //_mainSwitch.transform = CGAffineTransformMakeScale(1.5, 1);
    _mainSwitch.backgroundColor = UIColorFromRGB(0xEEEEEE);
    _mainSwitch.onTintColor = [UIColor redColor];
    _mainSwitch.layer.cornerRadius = 15;
    if ([self.remind intValue]==1) {
        _mainSwitch.on = YES;
    }else{
        _mainSwitch.on = NO;
    }
    [_mainSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mainSwitch];
    
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(15*MYWIDTH, _tishiLab.bottom+50*MYWIDTH, kScreenWidth-30*MYWIDTH, 50*MYWIDTH);
    nextBtn.layer.cornerRadius = 25*MYWIDTH;
    [nextBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"删除该路线" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
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
    NSString *url = @"/mbtwz/route?action=setOneRouteIsremind";
    NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"routeid\":\"%@\",\"route_status\":\"%@\"}",self.routeid,route_status]};
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:params FinishedLogin:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
    }];
    
}
- (void)nextClick{
    NSString *url = @"/mbtwz/route?action=delOneRoute";
    NSDictionary* params = @{@"data":[NSString stringWithFormat:@"{\"routeid\":\"%@\"}",self.routeid]};
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:params FinishedLogin:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            jxt_showToastTitle(@"删除成功", 1);
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MyLineViewController1 class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            jxt_showToastTitle([dic objectForKey:@"msg"], 1);
        }
    }];
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
