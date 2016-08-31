//
//  NSError+HTTP.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSError+HTTP.h"

@implementation NSError (HTTP)

+ (NSError *)reqeustError:(NSInteger)code message:(NSString *)message{
    NSDictionary *userInfo = nil;
    if (message) {
        userInfo = @{NSLocalizedDescriptionKey: message};
    }
    return [NSError errorWithDomain:RequestErrorDomain code:code userInfo:userInfo];
}
+ (NSError *)responseError:(NSInteger)code message:(NSString *)message{
    NSDictionary *userInfo = nil;
    if (message) {
        userInfo = @{NSLocalizedDescriptionKey: message};
    }
    return [NSError errorWithDomain:ResponseErrorDomain code:code userInfo:userInfo];
}
+ (NSError *)bussinessError:(NSInteger)code message:(NSString *)message{
    NSDictionary *userInfo = nil;
    if (message) {
        userInfo = @{NSLocalizedDescriptionKey: message};
    }
    return [NSError errorWithDomain:BussinessErrorDomain code:code userInfo:userInfo];
}


- (NSString *)errorMessage{
    NSString *message = nil;
    switch (self.code) {
        case kCFHostErrorHostNotFound:{
            message = @"网络无法连接";
        }break;
        case NSURLErrorCancelled:{
            message = @"请求取消";
        }break;
        case NSURLErrorBadURL:{
            message = @"地址出错";
        }break;
        case NSURLErrorTimedOut:{
            message = @"连接超时，请稍后重试";
        }break;
        case NSURLErrorCannotFindHost:{
            message = @"服务器未找到";
        }break;
        case NSURLErrorCannotConnectToHost:{
            message = @"暂时无法连接";
        }break;
        case NSURLErrorNetworkConnectionLost:{
            message = @"网络连接丢失";
        }break;
        case NSURLErrorBadServerResponse:{
            message = @"服务器响应出错";
        }break;
        case NSURLErrorCannotDecodeContentData:{
            message = @"不能解码响应数据";
        }break;
        case NSURLErrorCannotParseResponse:{
            message = @"不能解析响应数据";
        }break;
        case NSURLErrorNotConnectedToInternet:{
            message = @"网络已断开，请连接后重试";
        }break;
        default:{
            message = @"连接超时,请稍后重试";
        }break;
    }
    return message;
}


@end
