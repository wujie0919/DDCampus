//
//  NSString+HTTP.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSString+HTTP.h"

@implementation NSString (HTTP)

- (NSString *)urlAction:(NSString *)action{
    return [[[NSURL URLWithString:self] URLByAppendingPathComponent:action] absoluteString];
}

@end
