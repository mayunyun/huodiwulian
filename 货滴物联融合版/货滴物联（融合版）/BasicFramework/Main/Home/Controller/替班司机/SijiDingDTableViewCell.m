//
//  SijiDingDTableViewCell.m
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "SijiDingDTableViewCell.h"

@implementation SijiDingDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 12;
    self.button.layer.borderWidth = 1;
    self.button.layer.borderColor = [UIColor redColor].CGColor;
    [self.button setTitleColor:MYColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
