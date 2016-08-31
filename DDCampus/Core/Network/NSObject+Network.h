//
//  NSObject+Network.h
//  DDCampus
//
//  Created by wu on 16/8/9.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id result);
typedef void (^failureBlock)(NSError * error);

@interface NSObject (Network)

/**
 *  post请求，请用于发送给服务器数据
 *
 *  @param url     后缀地址，属于哪个模块
 *  @param tag     请求tag
 *  @param param   参数
 *  @param success 成功block
 *  @param failure 失败block
 *
 *  @return
 */
- (AFHTTPRequestOperation *)Network_Post:(NSString *)module
                                 tag:(NSInteger)tag
                               param:(NSDictionary *)param
                             success:(successBlock)success
                             failure:(failureBlock)failure;


@end
