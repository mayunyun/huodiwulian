//
//  TiBanWuLiuSJRZViewCell.h
//  MaiBaTe
//
//  Created by LONG on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiBanWuLiuSJRZViewCellNewPart1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *license_type;
@property (weak, nonatomic) IBOutlet UITextField *driving_age;
@property(nonatomic,strong)void(^yzmCodeBlock)(NSString *);
@end
