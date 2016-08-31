//
//  NSMutableDictionary+HTTP.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSMutableDictionary+HTTP.h"

@implementation NSMutableDictionary (HTTP)

//当对象为空时，自动设置为NULL对象
- (void)setObject:(id)anObject forOBField:(id <NSCopying>)aKey{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    } else {
        [self setObject:[NSNull null] forKey:aKey];
    }
}

//当对象为空时，不设置值
- (void)setObject:(id)anObject forOPField:(id <NSCopying>)aKey{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}


@end
