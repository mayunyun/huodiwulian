//
//  TongChXiaoCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/2/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHXiaoJModel1.h"
@interface TongChXiaoCell1 : UITableViewCell
@property(nonatomic,strong)TCHXiaoJModel1 *dataModel;

- (void)setwithDataModel:(TCHXiaoJModel1 *)dataModel;
@end
