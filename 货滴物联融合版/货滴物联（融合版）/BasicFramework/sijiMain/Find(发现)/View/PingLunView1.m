//
//  PingLunView1.m
//  MaiBaTe
//
//  Created by LONG on 2017/9/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PingLunView1.h"
#import "PingLunTableViewCell1.h"
@interface PingLunView1 ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation PingLunView1
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setPLArray:(NSArray *)PLArray
{
    _PLArray = PLArray;
        
    if(_PLArray.count==0)
    {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    [self reloadData];
    
    self.width = kScreenWidth-40*MYWIDTH;
    self.height = [self cellsTotalHeight];
    self.fixedHeight = @([self cellsTotalHeight]);
    self.fixedWidth = @(kScreenWidth);


}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.backgroundColor = UIColorFromRGB(0xEEEEEE);
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[PingLunTableViewCell1 class] forCellReuseIdentifier:NSStringFromClass([PingLunTableViewCell1 class])];
        self.scrollEnabled = NO;

        
    }
    return self;
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreenWidth tableView:tableView];
    
    return h;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%@",self.PLArray);
    return self.PLArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class currentClass = [PingLunTableViewCell1 class];
    PingLunTableViewCell1 *cell = nil;
    
    //        if(data.picturesArray.count>3)
    //        {
    //            currentClass = [SKYoujiCell class];
    //        }
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.backgroundColor = [UIColor clearColor];
    [cell setwithData:self.PLArray inter:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
@end
