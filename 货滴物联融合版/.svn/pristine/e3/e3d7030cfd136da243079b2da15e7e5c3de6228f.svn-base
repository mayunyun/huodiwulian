//
//  BaseTabBar1.h
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//
/*===============================================================================
 
 自定义UITabBar；
 
 ===============================================================================*/

#import <UIKit/UIKit.h>

@class BaseTabBar1;

@protocol BaseTabBar1Delegate <NSObject>

@optional

- (void)tabBarMiddle_BTClickSY:(BaseTabBar1 *)tabBar;
- (void)tabBarMiddle_BTClickKY:(BaseTabBar1 *)tabBar;

@end


@interface BaseTabBar1 : UITabBar

@property (nonatomic, weak) id<BaseTabBar1Delegate> myDelegate ;

@end
