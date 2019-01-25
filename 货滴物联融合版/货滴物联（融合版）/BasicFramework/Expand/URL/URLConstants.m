//
//  URLConstants.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/16.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#pragma mark -  * * * * * * * * * * * * * * 域名切换 * * * * * * * * * * * * * *

#if ENVIRONMENT == 0
/**
 *  @param 开发环境
 */
//NSString *const _Environment_Domain = @"http://www.maibat.com/maibate";
NSString *const _Environment_Domain = @"http://www.huodiwuliu.com";//@"http://www.huodikuaiyun.com";
//NSString *const _Environment_Domain = @"http://192.168.1.55/hdsy";

//http://www.huodiwulian.com
//http://118.190.47.231:8004/hdsy
//http://192.168.1.55/hdsy
//NSString *const _Environment_Domain = @"http://192.168.1.236:8280/hdsy";


#elif ENVIRONMENT ==1
/**
 *  @param 测试环境
 */
NSString *const _Environment_Domain = @"_API_Domain_测试环境";

#elif ENVIRONMENT ==2
/**
 *  @param 正式环境
 */
NSString *const _Production_Domain = @"";

#else

NSString *const _Environment_Domain = @"'ENVIRONMENT'-(0/1/2)";

#endif /* HTTPURLDefine_h */


#pragma mark -  * * * * * * * * * * * * * * URLs * * * * * * * * * * * * * *

NSString * const _Login_URL = @"/mbtwz/mallLogin?action=checkMallLogin";//登录
NSString * const _URL_PageDetail = @"";
NSString * const _URL_HomeList   = @"";
NSString * const _URL_HomePage_Banner   = @"";//轮播

