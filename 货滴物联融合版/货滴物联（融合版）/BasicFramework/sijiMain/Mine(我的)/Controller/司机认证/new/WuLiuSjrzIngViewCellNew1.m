//
//  WuLiuSJRZViewCell.m
//  MaiBaTe
//
//  Created by LONG on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WuLiuSjrzIngViewCellNew1.h"

@implementation WuLiuSjrzIngViewCellNew1

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
    [self.shiOneBut setAttributedTitle:tncString forState:UIControlStateNormal];
    [self.shiTwoBut setAttributedTitle:tncString forState:UIControlStateNormal];
}

- (IBAction)YZMButClick:(UIButton *)sender {
    [_phoneField resignFirstResponder];
    //if ([Command isMobileNumber:_phoneField.text]) {
        [self isExitsPhoneRequest];
        [sender startTime:60 title:@"请重新发送" waitTittle:@"s" finished:^(UIButton *button) {
        }];
//    }else{
//        jxt_showToastTitle(@"手机格式不正确", 1);
//    }
}
- (void)isExitsPhoneRequest{
    /*
     /mbtwz/register?action=getSMSCode"+callback1
     参数：phone  放在params中
     */
    NSString* urlstr = @"/mbtwz/register?action=getSMSCode";
    _phoneField.text = [Command convertNull:_phoneField.text];
    NSDictionary* params = @{@"params":[NSString stringWithFormat:@"{\"phone\":\"%@\"}",_phoneField.text]};
    [[RequestTool sharedRequestTool].userRequestTool loginWithUrl:urlstr Parameters:params FinishedLogin:^(id responseObject) {

        NSString* str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if ([str rangeOfString:@"false"].location!=NSNotFound) {
            jxt_showToastTitle(@"验证码发送失败", 1);
        }else{
            jxt_showToastTitle(@"验证码已发送", 1);
            NSString * string = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            if (_yzmCodeBlock) {
                self.yzmCodeBlock(string);
            }
        }
        
    }];
}

- (IBAction)shiOneBut:(UIButton *)sender {
        [self pushAlickViewStr:@"实例4"];
}
- (IBAction)shiTwoBut:(UIButton *)sender {
        [self pushAlickViewStr:@"实例5"];
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
