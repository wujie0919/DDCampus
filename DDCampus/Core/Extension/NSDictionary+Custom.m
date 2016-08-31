//
//  NSDictionary+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSDictionary+Custom.h"

@implementation NSDictionary (Custom)

- (NSData *)JSONData{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (error) {
            NSLog(@"JSON序列化出错--->error:%@",error);
        }
        return jsonData;
    } else {
        NSLog(@"JSON序列化出错--->error:存在非法数据类型");
        return nil;
    }
}
- (NSString *)JSONString{
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}


@end
