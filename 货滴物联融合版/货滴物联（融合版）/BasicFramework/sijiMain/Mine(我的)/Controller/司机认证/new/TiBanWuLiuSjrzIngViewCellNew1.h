//
//  TiBanWuLiuSJRZViewCell.h
//  MaiBaTe
//
//  Created by LONG on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiBanWuLiuSjrzIngViewCellNew1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *yzmField;
@property (weak, nonatomic) IBOutlet UILabel *threeLab;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIButton *shiThreeBut;
@property(nonatomic,strong)void(^yzmCodeBlock)(NSString *);
@end
