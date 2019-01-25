//
//  HomeRequestTool1.m
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "HomeRequestTool1.h"

@implementation HomeRequestTool1
-(void)homePageBannerList:(NSDictionary *)parameters FinishedTest:(void(^)(id responseObject))FinishedTest{
    [NetWorkManagerTwo requestDataWithURL:[NSString stringWithFormat:@"%@%@",_Environment_Domain,_URL_HomePage_Banner]
                              requestType:POST
                               parameters:parameters
                           uploadProgress:nil
                                  success:^(id responseObject,id data)
     {
         
         FinishedTest(data);
         
     } failure:^(NSError *error) {
         
     }];
    
}
@end
