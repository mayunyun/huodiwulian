//
//  ScoresTableViewCell1.h
//  MaiBaTe
//
//  Created by LONG on 17/8/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoresModel1.h"
@interface ScoresTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property(nonatomic,strong) ScoresModel1 *data;

@end
