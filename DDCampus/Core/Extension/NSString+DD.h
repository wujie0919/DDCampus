//
//  NSString+DD.h
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DD)
/**
 *  校验手机号码（包含虚拟运营商号码）
 *
 *  @return YES：有效 NO：无效
 */
- (BOOL)validatePhone;
/**
 *  验证是否是有效的字符串
 *
 *  @return YES：有效  NO：无效
 */
- (BOOL)isValidString;

-(NSInteger)characterLength;
@end
