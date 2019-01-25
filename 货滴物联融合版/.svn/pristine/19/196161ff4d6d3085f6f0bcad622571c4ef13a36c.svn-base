//
//  RequestTool1.m
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "RequestTool1.h"

@implementation RequestTool1

+ (instancetype)sharedRequestTool
{
    static RequestTool1 *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            
            tool = [RequestTool1 new];
            
            tool.UserRequestTool1    = [UserRequestTool1 new];
            tool.homeRequestTool1    = [HomeRequestTool1 new];
        }
    });
    return tool;
}

@end
