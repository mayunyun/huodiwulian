//
//  HongbaoDeViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/9/30.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "HongbaoDeViewController1.h"
#import "HongBaoJLViewController1.h"
@interface HongbaoDeViewController1 ()

@end

@implementation HongbaoDeViewController1
{
    UILabel *lab;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem.leftBarButtonItem setTintColor:UIColorFromRGB(0xf3e3b0)];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
//视图将要消失时取消隐藏
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationItem.leftBarButtonItem setTintColor:NavBarItemColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.font = [UIFont boldSystemFontOfSize:17];;
    title.text = @"红包祥情";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColorFromRGB(0xf3e3b0);
    self.navigationItem.titleView = title;
    
    UIButton* rightBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBarBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBarBtn setTitle:@"红包记录" forState:UIControlStateNormal];
    [rightBarBtn setTitleColor:UIColorFromRGB(0xf3e3b0) forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightBaclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc]initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    UIImageView *bgimgae = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH)];
    bgimgae.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:bgimgae];
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenW/2-30*MYWIDTH, 160*MYWIDTH, 60*MYWIDTH, 60*MYWIDTH)];
    NSString *image = [NSString stringWithFormat:@"%@/%@/%@",_Environment_Domain,_model.folder,_model.autoname];
    NSLog(@"%@",image);
    [headimage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    headimage.layer.masksToBounds = YES;
    headimage.layer.cornerRadius = headimage.width/2;
    [bgimgae addSubview:headimage];
    
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(0, headimage.bottom, UIScreenW, 20)];
    namelab.font = [UIFont boldSystemFontOfSize:14];;
    namelab.text = [NSString stringWithFormat:@"%@",_model.custname];
    namelab.textAlignment = NSTextAlignmentCenter;
    namelab.textColor = [UIColor blackColor];
    [bgimgae addSubview:namelab];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(0, UIScreenH/2-40, UIScreenW, 80)];
    lab.font = [UIFont boldSystemFontOfSize:50];;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    [bgimgae addSubview:lab];
    if ([self.type isEqualToString:@"1"]) {
        [self searchRedEnvelopes];
    }else{
        double val = ((double)arc4random() / 0x100000000);
        while (val<0.5) {
            val = ((double)arc4random() / 0x100000000);
        }
        lab.text = [NSString stringWithFormat:@"%.2f元",val];
        [self dataRequest:[NSString stringWithFormat:@"%.2f",val]];
    }

    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, lab.bottom, UIScreenW, 20)];
    lab2.font = [UIFont boldSystemFontOfSize:12];;
    lab2.text = @"已存入余额";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.textColor = [UIColor blueColor];
    [bgimgae addSubview:lab2];
}
- (void)rightBaclick{
    
    HongBaoJLViewController1 *details = [[HongBaoJLViewController1 alloc]init];
    details.model = _model;
    [self.navigationController pushViewController:details animated:YES];
}
- (void)searchRedEnvelopes{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:_xiaoxiid forKey:@"msgid"];
    NSDictionary* params = @{@"data":[Command dictionaryToJson:param]};
    
    NSString *url = @"/mbtwz/logisticssendwz?action=searchRedEnvelopes";
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:params FinishedLogin:^(id responseObject) {
        
        NSArray* arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",arr);
        if (arr.count) {
            lab.text = [NSString stringWithFormat:@"%@元",[arr[0] objectForKey:@"money"]];
        }
        
    }];
}
- (void)dataRequest:(NSString *)redmoney{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.orderno forKey:@"orderno"];
    [param setValue:redmoney forKey:@"redmoney"];
    //[param setValue:_xiaoxiid forKey:@"msgid"];
    NSDictionary* params = @{@"data":[Command dictionaryToJson:param]};
    
    NSString *url = @"/mbtwz/logisticssendwz?action=dismantlingRedEnvelopes";
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:url Parameters:params FinishedLogin:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
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
