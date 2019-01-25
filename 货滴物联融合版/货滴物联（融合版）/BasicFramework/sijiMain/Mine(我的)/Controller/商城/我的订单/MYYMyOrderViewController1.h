//
//  MYYMyOrderViewController1.h
//  BaseFrame
//
//  Created by apple on 17/5/10.
//  Copyright © 2017年 济南联祥技术有限公司. All rights reserved.
//

#import "BasicMainVC1.h"
#import "MYYMyOrderHeaderTitleView1.h"
#import "MYYAllOrderViewController1.h"
#import "MYYPayMentOrderViewController1.h"
#import "MYYFaHuoViewController1.h"
#import "MYYGoodsOrderViewController1.h"
#import "MYYCompleteOrderViewController1.h"

@interface MYYMyOrderViewController1 : BasicMainVC1<MYYMyOrderHeaderTitleView1Delegate,UIScrollViewDelegate>
//头部的选项卡
@property(nonatomic,strong) MYYMyOrderHeaderTitleView1 *titleView;

//滚动条
@property(nonatomic,strong) UIScrollView *scrollView;

//大数组，子控制器的
@property(nonatomic,strong) NSMutableArray *childViews;

@property(nonatomic,strong) NSString *push;
@end
