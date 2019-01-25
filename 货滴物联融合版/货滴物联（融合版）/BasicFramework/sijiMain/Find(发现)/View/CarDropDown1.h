//
//  CarDropDown1.h
//  MaiBaTe
//
//  Created by LONG on 2017/9/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CarDropDown1;
@protocol CarDropDown1Delegate
- (void) CarDropDown1DelegateMethod: (CarDropDown1 *) sender index:(NSInteger)index;
@end

@interface CarDropDown1 : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, retain) id <CarDropDown1Delegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b :(CGFloat *)height :(NSArray *)arr :(NSString *)direction;

@end
