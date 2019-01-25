//
//  NewAllViewController1.h
//  MaiBaTe
//
//  Created by LONG on 17/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BasicMainVC1.h"
#import "MainModel.h"
#import "HuoDongModel1.h"

@interface NewAllViewController1 : BasicMainVC1<UIScrollViewDelegate>
@property (nonatomic,strong)MainModel *model;
@property (nonatomic,strong)HuoDongModel1 *huomodel;

@property (nonatomic,assign)int type;
@property (strong, nonatomic)  UILabel *titleLab;
@property (strong, nonatomic)  UIWebView *webView;

@end
