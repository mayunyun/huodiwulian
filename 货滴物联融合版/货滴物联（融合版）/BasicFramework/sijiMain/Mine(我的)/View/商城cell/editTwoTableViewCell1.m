//
//  editTwoTableViewCell1.m
//  MaiBaTe
//
//  Created by 钱龙 on 17/10/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "editTwoTableViewCell1.h"

@implementation editTwoTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)provenceBtnClicked:(id)sender {
    if (_provenceBtnBlock) {
        self.provenceBtnBlock();
    }
}
- (IBAction)cityBtnClicked:(id)sender {
    if (_cityBtnBlock) {
        self.cityBtnBlock();
    }
}
- (IBAction)townBtnClicked:(id)sender {
    if (_townBtnBlock) {
        self.townBtnBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
