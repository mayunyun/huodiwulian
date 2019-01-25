//
//  CarHomeHeadView1.h
//  MaiBaTe
//
//  Created by LONG on 2017/9/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarHomeHeadView1Delegate <NSObject>

@optional
-(void)CarHomeHeadView1BtnHaveString:(NSString *)brandname idStr:(NSString *)idStr;

@end

@interface CarHomeHeadView1 : UICollectionReusableView

@property(nonatomic,weak) id<CarHomeHeadView1Delegate> delegate;


-(void)dataHeadView:(NSMutableArray *)data;
@end
