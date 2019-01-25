//
//  MYYMyOrderHeaderTitleView1.h
//  BaseFrame
//
//  Created by apple on 17/5/10.
//  Copyright © 2017年 济南联祥技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYYMyOrderHeaderTitleView1;

@protocol MYYMyOrderHeaderTitleView1Delegate <NSObject>

@optional
- (void)titleView:(MYYMyOrderHeaderTitleView1 *)titleView scollToIndex:(NSInteger)tagIndex;

@end
@interface MYYMyOrderHeaderTitleView1 : UIView
@property (nonatomic,weak) id<MYYMyOrderHeaderTitleView1Delegate>delegate;

-(void)wanerSelected:(NSInteger)tagIndex;
@end
