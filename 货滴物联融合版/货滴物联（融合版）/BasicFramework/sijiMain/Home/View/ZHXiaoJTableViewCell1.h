//
//  ZHXiaoJTableViewCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/3/6.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHXiaoJModel1.h"
@interface ZHXiaoJTableViewCell1 : UITableViewCell<AMapSearchDelegate>
@property(nonatomic,strong)ZHXiaoJModel1 *dataModel;
@property(nonatomic,strong)UIViewController *controller;
@property (nonatomic, strong) AMapSearchAPI *search;

- (void)setwithDataModel:(ZHXiaoJModel1 *)dataModel locationStr:(CLLocationCoordinate2D)location;

@end
