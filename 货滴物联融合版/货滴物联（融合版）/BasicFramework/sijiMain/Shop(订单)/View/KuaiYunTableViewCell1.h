//
//  KuaiYunTableViewCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/2/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHKuaiYModel1.h"
@interface KuaiYunTableViewCell1 : UITableViewCell
@property(nonatomic,strong)TCHKuaiYModel1 *dataModel;

- (void)setwithDataModel:(TCHKuaiYModel1 *)dataModel;

@end
