//
//  NSError+HTTP.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const RequestErrorDomain = @"RequestErrorDomain";
static NSString *const ResponseErrorDomain = @"ResponseErrorDomain";
static NSString *const BussinessErrorDomain = @"BussinessErrorDomain";

@interface NSError (HTTP)

+ (NSError *)reqeustError:(NSInteger)code message:(NSString *)message;
+ (NSError *)responseError:(NSInteger)code message:(NSString *)message;
+ (NSError *)bussinessError:(NSInteger)code message:(NSString *)message;

- (NSString *)errorMessage;

@end
