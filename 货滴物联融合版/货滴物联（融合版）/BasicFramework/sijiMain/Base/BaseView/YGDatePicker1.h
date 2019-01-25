//
//  YGDatePicker1.h
//  CashBack
//
//  Created by Rainy on 2017/10/17.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGDatePicker1 : NSObject

+ (void)showDateDetermineChoose:(void(^)(NSString *dateString))determineChoose;

@end
