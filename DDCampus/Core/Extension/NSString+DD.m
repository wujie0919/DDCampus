//
//  NSString+DD.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "NSString+DD.h"

@implementation NSString (DD)

- (BOOL)isValidString{
    if (!self) {
        return NO;
    }
    if (self == nil) {
        return NO;
    }
    if ([self isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}

- (BOOL)validatePhone
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(14[57])|(17[0])|(17[7])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

@end
