//
//  RequestTool1.h
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRequestTool1.h"
#import "HomeRequestTool1.h"

@interface RequestTool1 : NSObject

+ (instancetype)sharedRequestTool;

/** 用户 */
@property(nonatomic,strong)UserRequestTool1        *UserRequestTool1;
/** 首页 */
@property(nonatomic,strong)HomeRequestTool1        *homeRequestTool1;

@end
