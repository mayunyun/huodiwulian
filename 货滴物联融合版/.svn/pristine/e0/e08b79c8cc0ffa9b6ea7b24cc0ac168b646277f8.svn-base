//
//  SijiDingDetailsViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "SijiDingDetailsViewController.h"

@interface SijiDingDetailsViewController ()
@property(nonatomic,strong)ZhaopinModel*model;

@end

@implementation SijiDingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"司机订单详情";
    self.view.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [self selectDriverRecrJoinDet];
    
}
- (void)selectDriverRecrJoinDet
{
    
    NSString *URLStr = @"/mbtwz/driverrecruit?action=selectDriverRecrJoinDet";
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",self.id] forKey:@"orderid"];
    NSDictionary* KCparams = @{@"data":[Command dictionaryToJson:param]};//

    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:KCparams FinishedLogin:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"flag"] intValue]==200) {
            
            self.model=[[ZhaopinModel alloc]init];
            [self.model setValuesForKeysWithDictionary:[[dic objectForKey:@"response"][0] objectForKey:@"orderdet"][0]];
            [self createUI];
        }
       
        
        
    }];
}
- (void)createUI{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, statusbarHeight+44)];
    bgview.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [self.view addSubview:bgview];
    
    UIView *bgviews = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.bottom+20*MYWIDTH, UIScreenW, 320*MYWIDTH)];
    bgviews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgviews];
    NSArray *imageArr = @[@"sjj",@"zsdh",@"起点",@"终点",@"dbb",@"dbb",@"sjfy"];
    NSArray *nameArr = @[@"姓名",@"电话",@"起点",@"终点",@"出发时间",@"结束时间",@"司机费用"];
    NSArray *Arr = @[[NSString stringWithFormat:@"%@",self.model.name],[NSString stringWithFormat:@"%@",self.model.phone],[NSString stringWithFormat:@"%@%@%@",self.model.sprovince,self.model.scity,self.model.scounty],[NSString stringWithFormat:@"%@%@%@",self.model.eprovince,self.model.ecity,self.model.ecounty],[NSString stringWithFormat:@"%@",self.model.stime],[NSString stringWithFormat:@"%@",self.model.etime],[NSString stringWithFormat:@"%@元/人",self.model.price],];
    for (int i = 0; i<7; i++) {
        UIView *xian1 = [[UIView alloc]initWithFrame:CGRectMake(15*MYWIDTH, 40*MYWIDTH*(i+1), bgviews.width-15*MYWIDTH, 1*MYWIDTH)];
        xian1.backgroundColor = UIColorFromRGBValueValue(0xEEEEEE);
        [bgviews addSubview:xian1];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15*MYWIDTH,  xian1.top-29*MYWIDTH, 18*MYWIDTH, 18*MYWIDTH)];
        image.image = [UIImage imageNamed:imageArr[i]];
        [bgviews addSubview:image];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(image.right+10*MYWIDTH, xian1.top-40*MYWIDTH, 80*MYWIDTH, 40*MYWIDTH)];
        titleLab.text = nameArr[i];
        titleLab.textColor = UIColorFromRGBValueValue(0x000000);
        titleLab.font = [UIFont systemFontOfSize:14*MYWIDTH];
        [bgviews addSubview:titleLab];
        
        UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.right, xian1.top-40*MYWIDTH, bgviews.width-15*MYWIDTH-titleLab.right, 40*MYWIDTH)];
        titleLab1.text = Arr[i];
        titleLab1.textAlignment = NSTextAlignmentRight;
        if (i==6) {
            titleLab1.textColor = UIColorFromRGBValueValue(0xFF0000);
        }else{
            titleLab1.textColor = UIColorFromRGBValueValue(0x000000);
        }
        titleLab1.font = [UIFont systemFontOfSize:14*MYWIDTH];
        [bgviews addSubview:titleLab1];
    }
    UILabel *statusLab = [[UILabel alloc]initWithFrame:CGRectMake(0, bgviews.height-40*MYWIDTH, bgviews.width-15*MYWIDTH, 40*MYWIDTH)];
    statusLab.textAlignment = NSTextAlignmentRight;
    if ([self.model.status intValue]==5) {
        statusLab.text = @"接单成功";
    }else if ([self.model.status intValue]==4){
        statusLab.text = @"接单失败";
    }else if ([self.model.status intValue]==3){
        statusLab.text = @"已结束";
    }else if ([self.model.status intValue]==2){
        statusLab.text = @"待付款";
    }else if ([self.model.status intValue]==1){
        statusLab.text = @"进行中";
    }else if ([self.model.status intValue]==0){
        statusLab.text = @"等待确认";
    }
    else{
        statusLab.text = @"";
    }
    statusLab.textColor = UIColorFromRGBValueValue(0xFF0000);
    statusLab.font = [UIFont systemFontOfSize:14*MYWIDTH];
    [bgviews addSubview:statusLab];
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
