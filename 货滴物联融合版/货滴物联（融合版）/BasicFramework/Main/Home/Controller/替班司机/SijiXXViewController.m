//
//  SijiXXViewController.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "SijiXXViewController.h"
#import "SijixxModel.h"
#import "SijiXXTableViewCell.h"

@interface SijiXXViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation SijiXXViewController
{
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    [self loadNewSearchSuyunorder];
    [self tableview];
}
- (void)loadNewSearchSuyunorder
{
    if (_page==1) {
        [_dataArr removeAllObjects];
    }
    NSString *URLStr = @"/mbtwz/driverrecruit?action=selectDriverList";
    NSDictionary* params = @{@"page":[NSString stringWithFormat:@"%li",(long)_page],@"rows":@"8"};
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:URLStr Parameters:params FinishedLogin:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"rows"];
        NSLog(@"%@",array);
        if (!IsEmptyValue(array)) {
            for (NSDictionary*dic in array) {
                SijixxModel *model=[[SijixxModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                //追加数据
                [_dataArr addObject:model];
            }
        }
        [_tableview reloadData];
        
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 175;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * stringCell = @"SijiXXTableViewCell";
    SijiXXTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stringCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:stringCell owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count) {
        SijixxModel *model = _dataArr[indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@",model.driver_name];
        cell.phone.text = [NSString stringWithFormat:@"%@",model.driver_phone];
        cell.type.text = [NSString stringWithFormat:@"驾驶证  %@",model.type];
        cell.year.text = [NSString stringWithFormat:@"驾龄  %@",model.year];

        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_Environment_Domain,model.pic]] placeholderImage:nil];
        if ([model.authentication intValue]==0) {
            cell.button.hidden = YES;
            cell.xian.hidden = YES;
        }else{
            cell.button.hidden = NO;
            cell.xian.hidden = NO;
        }
        cell.button.tag = indexPath.row;
        [cell.button setTitleColor:MYColor forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(pushAlickViewStr:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}
- (void)pushAlickViewStr:(UIButton *)but{
    SijixxModel *model = _dataArr[but.tag];
    
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:YES];
    [SMAlert setcontrolViewbackgroundColor:[UIColor whiteColor]];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(UIScreenW/2-165*MYWIDTH, 0, 330*MYWIDTH, 240*MYWIDTH)];
    bgview.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgview.width, bgview.height)];
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_Environment_Domain,model.pic]] placeholderImage:nil];
    [bgview addSubview:image];
    
    [SMAlert showCustomView:bgview];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (UITableView *)tableview{
    if (_tableview == nil) {
        
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH-64-40)];
        if (statusbarHeight>20) {
            _tableview.frame = CGRectMake(0, 0, UIScreenW, UIScreenH-88-40);
            
        }
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
        [self.view addSubview:_tableview];
        
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addnewData)];
        
    }
    return _tableview;
    
}
- (void)loadNewData{
    _page=1;
    [self loadNewSearchSuyunorder];
    
    [_tableview.mj_header endRefreshing];
    
}
- (void)addnewData{
    _page ++;
    [self loadNewSearchSuyunorder];
    [_tableview.mj_footer endRefreshing];
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
