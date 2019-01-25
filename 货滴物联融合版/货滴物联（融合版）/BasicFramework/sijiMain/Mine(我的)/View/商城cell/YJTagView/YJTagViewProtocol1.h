//
//  YJTagViewProtocol1.h
//  tagsView
//
//  Created by Jake on 2017/6/24.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJTagView1;
@protocol YJTagViewDataSource <NSObject>

@required
- (NSInteger)numOfItemstagView:(YJTagView1 *)tagView;

- (NSString *)tagView:(YJTagView1 *)tagView titleForItemAtIndex:(NSInteger)index;

@end
@protocol YJTagViewDelegate <NSObject>

@optional
- (void)tagView:(YJTagView1 *)tagView didSelectedItemAtIndex:(NSInteger)index;

/**
 使用frame布局实现一下代理方法获得填充数据后的正确的高度(高度已内部调整)
 
 @param tagView tagView
 @param height 高度
 */
- (void)tagView:(YJTagView1 *)tagView heightUpdated:(CGFloat)height;

@end


@class DWTagView1;

@protocol DWTagViewDataSource <NSObject>

@required

- (NSInteger)DWnumOfItemstagView:(DWTagView1 *)tagView;

- (NSString *)DWTagView1:(DWTagView1 *)tagView titleForItemAtIndex:(NSInteger)index;
@end
@protocol DWTagViewDelegate <NSObject>

@optional

- (void)DWTagView1:(DWTagView1 *)tagView didSelectedItemAtIndex:(NSInteger)index;

/**
 使用frame布局实现一下代理方法获得填充数据后的正确的高度(高度已内部调整)
 
 @param tagView tagView
 @param height 高度
 */
- (void)DWTagView1:(DWTagView1 *)tagView heightUpdated:(CGFloat)height;
@end

@class PLTagView1;
@protocol PLTagViewDataSource <NSObject>

@required
- (NSInteger)PLnumOfItemstagView:(PLTagView1 *)tagView;

- (NSString *)PLTagView1:(PLTagView1 *)tagView titleForItemAtIndex:(NSInteger)index;

@end
@protocol PLTagViewDelegate <NSObject>

@optional
- (void)PLTagView1:(PLTagView1 *)tagView didSelectedItemAtIndex:(NSInteger)index;

/**
 使用frame布局实现一下代理方法获得填充数据后的正确的高度(高度已内部调整)
 
 @param tagView tagView
 @param height 高度
 */
- (void)PLTagView1:(PLTagView1 *)tagView heightUpdated:(CGFloat)height;

@end
