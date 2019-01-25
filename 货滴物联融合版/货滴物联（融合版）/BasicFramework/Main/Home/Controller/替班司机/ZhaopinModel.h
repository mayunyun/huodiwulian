//
//  ZhaopinModel.h
//  BasicFramework
//
//  Created by LONG on 2018/11/28.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhaopinModel : NSObject
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *orderno;
@property (nonatomic,strong)NSString *custid;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *sprovince;
@property (nonatomic,strong)NSString *scity;
@property (nonatomic,strong)NSString *scounty;
@property (nonatomic,strong)NSString *eprovince;
@property (nonatomic,strong)NSString *ecity;
@property (nonatomic,strong)NSString *ecounty;
@property (nonatomic,strong)NSString *neednum;
@property (nonatomic,strong)NSString *stime;
@property (nonatomic,strong)NSString *etime;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *createtime;
@property (nonatomic,strong)NSString *joincount;

/*
 {
 "id": 1,   id
 "orderno": "XXDG12312",   订单号
 "custid": 99,   发布人id
 "name": "张三",   联系人
 "phone": "15165155555",   联系电话
 "sprovince": "山东省",   出发地省
 "scity": "济南市",   出发地市
 "scounty": "高新区",   出发地县
 "eprovince": "北京市",   目的地省
 "ecity": "北京市",   目的地市
 "ecounty": "朝阳区",   目的地县
 "neednum": 2,   需要司机人数
 "stime": "2018-11-20 23:55:00",   出车时间
 "etime": "2018-11-21 23:55:00",   结束时间
 "price": 100,   司机报酬 元/人
 "status": 0,   状态 0：发布，1：进行中，2：待付款，3：结束 （默认0）
 "createtime": "2018-11-20 23:55:00"   订单创建时间
 }
 {
 "id": 1,    id
 "orderno": "XXDG12312",    订单号
 "custid": 99,    发布人id
 "name": "张三",    联系人
 "phone": "15165155555",    联系人电话
 "sprovince": "山东省",    出发地省
 "scity": "济南市",    出发地市
 "scounty": "高新区",    出发地县
 "eprovince": "北京市",    目的地省
 "ecity": "北京市",    目的地市
 "ecounty": "朝阳区",    目的地县
 "neednum": 2,    需要人数
 "stime": "2018-11-20 23:55:00",    出发时间
 "etime": "2018-11-21 23:55:00",    结束时间
 "price": 100,    单人报酬
 "status": 0,    状态   0：未开始，1：进行中，2：待付款，3：已结束
 "createtime": "2018-11-20 23:55:00",    订单创建时间
 "joincount": 0    已接单司机人数
 }
 */
@end
