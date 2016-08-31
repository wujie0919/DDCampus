//
//  NSMutableDictionary+HTTP.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (HTTP)

//当对象为空时，自动设置为NULL对象
- (void)setObject:(id)anObject forOBField:(id <NSCopying>)aKey;

//当对象为空时，不设置值
- (void)setObject:(id)anObject forOPField:(id <NSCopying>)aKey;

@end
