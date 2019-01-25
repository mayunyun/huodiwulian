//
//  MYYOrterClassTableViewCell1.m
//  MaiBaTe
//
//  Created by LONG on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MYYOrterClassTableViewCell1.h"

@implementation MYYOrterClassTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headerImage.layer.cornerRadius = 5;
    self.headerImage.clipsToBounds = YES;
    self.headerImage.contentMode = UIViewContentModeScaleAspectFit;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
