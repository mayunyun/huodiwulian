//
//  HongBaoJLViewController1.m
//  BasicFramework
//
//  Created by LONG on 2018/9/30.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "HongBaoJLViewController1.h"
#import "HongBaoTableViewCell1.h"
@interface HongBaoJLViewController1 ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HongBaoJLViewController1
{
    UILabel *_zonglab;
    UILabel *_allcount;
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
    self.view.backgroundColor = UIColorFromRGB(0xd9583f);
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    title.font = [UIFont boldSystemFontOfSize:17];;
    title.text = @"收到的红包";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColorFromRGB(0xf3e3b0);
    self.navigationItem.titleView = title;
    [self loadNew];
    [self tableview];
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight);
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_tableview];
        
        
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250*MYWIDTH)];
        head.backgroundColor = UIColorFromRGB(0xEEEEEE);
        _tableview.tableHeaderView = head;
        
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenW/2-30*MYWIDTH, 45*MYWIDTH, 60*MYWIDTH, 60*MYWIDTH)];
        NSString *image = [NSString stringWithFormat:@"%@/%@/%@",_Environment_Domain,_model.folder,_model.autoname];
        NSLog(@"%@",image);
        [headimage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        headimage.layer.masksToBounds = YES;
        headimage.layer.cornerRadius = headimage.width/2;
        [head addSubview:headimage];
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(0, headimage.bottom+5*MYWIDTH, UIScreenW, 30*MYWIDTH)];
        namelab.font = [UIFont systemFontOfSize:16];;
        namelab.text = [NSString stringWithFormat:@"%@共收到",_model.custname];
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.textColor = [UIColor blackColor];
        [head addSubview:namelab];
        
        _zonglab = [[UILabel alloc]initWithFrame:CGRectMake(0, namelab.bottom, UIScreenW, 40*MYWIDTH)];
        _zonglab.font = [UIFont boldSystemFontOfSize:30];;
        //_zonglab.text = [NSString stringWithFormat:@"%@元",_model.custname];
        _zonglab.textAlignment = NSTextAlignmentCenter;
        _zonglab.textColor = [UIColor blackColor];
        [head addSubview:_zonglab];
        
        _allcount = [[UILabel alloc]initWithFrame:CGRectMake(0, _zonglab.bottom, UIScreenW, 40*MYWIDTH)];
        _allcount.font = [UIFont systemFontOfSize:13];;
        //_allcount.text = [NSString stringWithFormat:@"%@元",_model.custname];
        _allcount.textAlignment = NSTextAlignmentCenter;
        _allcount.textColor = [UIColor blackColor];
        [head addSubview:_allcount];
    }
    
    return _tableview;
    
}
#pragma 在这里面请求数据
- (void)loadNew
{
    [_dataArr removeAllObjects];
    //红包记录
    NSString *URLStr = @"/mbtwz/logisticssendwz?action=searchRedEnvelopesRecords";
    
    [[RequestTool1 sharedRequestTool].UserRequestTool1 loginWithUrl:URLStr Parameters:nil FinishedLogin:^(id responseObject) {
        self.dataArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"我的红包记录%@",self.dataArr);
        if (_dataArr.count) {
            NSDictionary *dic = _dataArr[0];
            _zonglab.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"allmoney"]];
            _allcount.text = [NSString stringWithFormat:@"收到红包%@个",[dic objectForKey:@"allcount"]];
        }
        [self.tableview reloadData];
        
    }];
    
    //15069019010
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArr.count == 0) {
        return 0;
    }
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HongBaoTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HongBaoTableViewCell1"];
    if (!cell) {
        cell = (HongBaoTableViewCell1 *)[[[NSBundle mainBundle]loadNibNamed:@"HongBaoTableViewCell1" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count) {
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"createtime"]];
        cell.money.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"money"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
