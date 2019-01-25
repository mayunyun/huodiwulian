//
//  TCHKuaiYOrderDetailHeaderCell1.h
//  BasicFramework
//
//  Created by LONG on 2018/2/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHKuaiYModel1.h"

@interface TCHKuaiYOrderDetailHeaderCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendtime;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic,strong)TCHKuaiYModel1 * model;

@end
