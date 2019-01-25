//
//  AddressManageViewController1.h
//  MaiBaTe
//
//  Created by 钱龙 on 17/10/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BasicMainVC1.h"
#import "AddressModel1.h"

@interface AddressManageViewController1 : BasicMainVC1

@property (nonatomic,assign) int flag;
@property (nonatomic,strong)NSString* controller;//@"1"订单，@"0"个人中心
@property (nonatomic, copy) void (^transVaule)(AddressModel1* model);
@end
