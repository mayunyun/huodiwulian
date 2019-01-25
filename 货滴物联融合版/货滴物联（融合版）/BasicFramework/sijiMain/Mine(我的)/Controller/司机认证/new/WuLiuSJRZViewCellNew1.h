//
//  WuLiuSJRZViewCell.h
//  MaiBaTe
//
//  Created by LONG on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuLiuSJRZViewCellNew1: UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *yzmField;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIButton *shiOneBut;
@property (weak, nonatomic) IBOutlet UIButton *shiTwoBut;

@property(nonatomic,strong)void(^yzmCodeBlock)(NSString *);
@end
