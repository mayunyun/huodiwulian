//
//  WuLiuSJRZViewCell.m
//  MaiBaTe
//
//  Created by LONG on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WuLiuSJRZViewCellNewPart1.h"

@implementation WuLiuSJRZViewCellNewPart1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"示例图片"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:MYColor  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:MYColor range:(NSRange){0,[tncString length]}];
    [self.shiThreeBut setAttributedTitle:tncString forState:UIControlStateNormal];
}
- (IBAction)shiThreeBut:(UIButton *)sender {
    [self pushAlickViewStr:@"实例6"];
}


- (void)pushAlickViewStr:(NSString *)str{
    [SMAlert setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SMAlert setTouchToHide:YES];
    [SMAlert setcontrolViewbackgroundColor:[UIColor whiteColor]];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(UIScreenW/2-165*MYWIDTH, 0, 330*MYWIDTH, 240*MYWIDTH)];
    bgview.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgview.width, bgview.height)];
    image.image = [UIImage imageNamed:str];
    [bgview addSubview:image];
    
    [SMAlert showCustomView:bgview];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
