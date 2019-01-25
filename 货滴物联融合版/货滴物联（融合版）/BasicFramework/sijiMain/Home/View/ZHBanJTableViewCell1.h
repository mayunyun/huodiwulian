//
//  ZHBanJTableViewCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/3/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHBanJModel1.h"
@interface ZHBanJTableViewCell1 : UITableViewCell<AMapSearchDelegate>
@property(nonatomic,strong)ZHBanJModel1 *dataModel;
@property(nonatomic,strong)UIViewController *controller;
@property (nonatomic, strong) AMapSearchAPI *search;

- (void)setwithDataModel:(ZHBanJModel1 *)dataModel locationStr:(CLLocationCoordinate2D)location;

@end
