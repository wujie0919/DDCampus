//
//  NSTools.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDUserModel;

@interface NSTools : NSObject

+ (NSString *)getClientId;

+ (void)setObject:(id)obj forKey:(NSString *)key;

+ (DDUserModel *)getUserInfo;

+ (BOOL)isCameraAvalible;
@end
