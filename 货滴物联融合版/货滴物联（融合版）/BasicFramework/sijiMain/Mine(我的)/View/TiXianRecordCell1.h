//
//  TiXianRecordCell1.h
//  MaiBaTe
//
//  Created by LONG on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiXianJLModel1.h"
@interface TiXianRecordCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *noteLab;
@property (weak, nonatomic) IBOutlet UILabel *isvalidLab;
@property (weak, nonatomic) IBOutlet UILabel *createtimeLab;

@property (nonatomic, strong)TiXianJLModel1 *data;

@end
