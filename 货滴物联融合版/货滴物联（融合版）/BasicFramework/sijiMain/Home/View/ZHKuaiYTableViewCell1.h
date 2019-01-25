//
//  ZHKuaiYTableViewCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/3/8.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHKuaiYModel1.h"
@interface ZHKuaiYTableViewCell1 : UITableViewCell
@property(nonatomic,strong)ZHKuaiYModel1 *dataModel;
@property(nonatomic,strong)UIViewController *controller;

- (void)setwithDataModel:(ZHKuaiYModel1 *)dataModel;
@end
