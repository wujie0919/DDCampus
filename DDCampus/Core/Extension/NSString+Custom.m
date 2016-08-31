//
//  NSString+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSString+Custom.h"
#import "NSData+Custom.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Custom)

- (id)objectFromJSONString{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
}

- (NSData *)toData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (UIColor *)toColor{
    
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return RGB(255, 255, 255);
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return RGB(255, 255, 255);
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    UIColor *color= [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
    return color;
}

static NSDateFormatter *dateFormatter = nil;
- (NSDate *)dateWithFormate:(NSString *)formate{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:formate];
    return [dateFormatter dateFromString:self];
}

- (NSString *)MD5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSString *)SHA1{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSString *)hmacSHA1:(NSString *)key{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cStr = [self UTF8String];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cStr, strlen(cStr), cHMAC);
    
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", cHMAC[i]];
    }
    
    hash = output;
    
    return hash;
}

- (NSString*)hmacSHA256:(NSString *)key{
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [self UTF8String];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hashString = [hash description];
    
    hashString = [hashString stringByReplacingOccurrencesOfString:@" " withString:@""];
    hashString = [hashString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hashString = [hashString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return hashString;
}

- (NSString *)hmacMD5:(NSString *)key{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned long keyLen = strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, (CC_LONG)keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, (CC_LONG)strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding];
    
    return hash;
}

- (BOOL)match:(NSString *)expression{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (!regex) {
        return NO;
    }
    
    NSRange range = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (range.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

- (BOOL)matchAnyOf:(NSArray *)array{
    for ( NSString * str in array ){
        if ( NSOrderedSame == [self compare:str options:NSCaseInsensitiveSearch] ){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isNumberOfDecimal:(NSUInteger)length{
    NSString *tempString = self;
    if (![tempString match:@"^[.0-9]+$"]) {
        return NO;
    }
    if ([tempString hasPrefix:@"00"]) {
        return NO;
    }
    NSRange tempRange = [tempString rangeOfString:@"."];
    if (tempRange.location!=NSNotFound) {
        tempString = [tempString substringFromIndex:tempRange.location+1];
        if (tempString.length>length) {
            return NO;
        }
        tempRange = [tempString rangeOfString:@"."];
        if (tempRange.location!=NSNotFound) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isTelephone{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_Telephone];
    return [pred evaluateWithObject:self];
}

- (BOOL)isIdCard{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_IDCard];
    return [pred evaluateWithObject:self];
}

//手机号
- (BOOL)isMobilphone{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_Mobilephone];
    return [pred evaluateWithObject:self];
}

- (BOOL)isMobilphoneCode{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_MobilephoneCoede];
    return [pred evaluateWithObject:self];
}

- (BOOL)isUserName{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_UserName];
    return [pred evaluateWithObject:self];
}

- (BOOL)isPassword{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_Password];
    return [pred evaluateWithObject:self];
}

- (BOOL)isEmail{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_Email];
    return [pred evaluateWithObject:self];
}

- (BOOL)isUrl{
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_Url];
    return [pred evaluateWithObject:self];
}


- (CGSize)sizeWithFont:(UIFont *)font destSize:(CGSize)max_size
{
    //    NPO(NSStringFromCGSize(max_size));
    CGSize cSize;
    //    if(IOS7_OR_LATER){
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dict = @{ NSFontAttributeName:font,
                            NSParagraphStyleAttributeName: paragraphStyle
                            };
    
    if(max_size.height > 0 && max_size.width > 0){
        CGRect strRect = [self boundingRectWithSize:max_size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
        cSize = strRect.size;
    }else{
        cSize = [self sizeWithAttributes:dict];
    }
    //    }else{
    //        if(max_size.height > 0 && max_size.width > 0){
    //            cSize = [str sizeWithFont:font forWidth:max_size.width lineBreakMode:NSLineBreakByWordWrapping];
    //        }else{
    //            cSize = [str sizeWithFont:font];
    //        }
    //    }
    return cSize;
}

/**
 *  生成 NSMutableAttributedString
 *
 *  @param string    内容
 *  @param font      字体
 *  @param color     字体色值
 *  @param lineSpace 行间距
 *  @param alignment 对齐方式
 *
 *  @return
 */
- (NSMutableAttributedString *)getAttributedStringWithfont:(UIFont *)font color:(UIColor *)color lineSpace:(float)lineSpace alignment:(NSTextAlignment)alignment
{
    if(!self || self.length == 0){
        return nil;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    if(color){
        [str addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:NSMakeRange(0, [self length])];
    }
    
    if(font)
        [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if(lineSpace > 0)
        [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName
                value:paragraphStyle
                range:NSMakeRange(0, [self length])];
    return str;
}

- (CGSize)getAttrbutedStringSizeWithmaxSize:(CGSize)max_size font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
    if(!font)
        font = [UIFont systemFontOfSize:12];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    CGRect strRect = [self boundingRectWithSize:max_size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return strRect.size;
}


- (NSString *)capitalFormChineseNumeral
{
    NSString * _inputNum = [NSString stringWithFormat:@"%.2f",self.doubleValue];
    if (_inputNum.length == 0) {
        return @"";
    }
    NSMutableString *_backStr = [[NSMutableString alloc] init];
    NSArray *_dArr = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *_eArr = @[@"仟",@"佰",@"拾",@"",@"仟",@"佰",@"拾",@"",@"仟",@"佰",@"拾",@""];
    NSArray *_pArr = @[@"分",@"角"];
    NSString*_zheng= @"";
    NSInteger _numlen = _inputNum.length;
    int _pitlen = 0;
    NSArray *_sepAr= [_inputNum componentsSeparatedByString:@"."];
    if (_sepAr.count == 2) {
        //有小数点儿的情况
        _pitlen = (int)[_sepAr[1] length];
        if ( _pitlen > 2) {
//            NPO(@"小数点儿后只支持两位哟");
            _pitlen = 2;
        }
    }
    else{
        _zheng = @"整";
    }
    
    int _haveValue = 0;
    NSString*_N= _sepAr[0];
    int _lenz  = (int)[_N length];
    for (int i = 0; i < _lenz; i++) {
        int _col = 7 - (_lenz - i - 1)%8;
        NSString *_curNum = [_N substringWithRange:NSMakeRange(i, 1)];
        if (_col <= 3 && _curNum.integerValue > 0) {
            _haveValue = 1;
        }
        
        // //当前是0 下一位还是0的话 就不显示  当前是0  col值是3或者7的话也不显示
        if (i + 1 != _N.length) {
            if (!([_curNum isEqualToString:@"0"] && ([[_N substringWithRange:NSMakeRange(i+1, 1)] isEqualToString:@"0"] || _col%4==3))) {
                [_backStr appendString:_dArr[[_curNum intValue]]];
            }
        }
        else if (i+1 == _N.length){
            if (!([_curNum isEqualToString:@"0"] && _col%4==3)) {
                [_backStr appendString:_dArr[[_curNum intValue]]];
            }
        }
        //加'仟', '佰', '拾', ……
        if (![_curNum isEqualToString:@"0"]) {
            [_backStr appendString:_eArr[_col]];
        }
        if (_col == 3 && _haveValue == 1) {
            [_backStr appendString:@"万"];
        }
        if (_col == 7 && _lenz-i > 4) {
            [_backStr appendString:@"亿"];
            _haveValue = 0;
        }
    }
    //避免0.55 00.55
    if (_lenz > 0 && [_N intValue] > 0) {
        [_backStr appendString:@"元"];
    }
    switch (_pitlen) {
        case 0:
            _zheng = @"整";
            break;
        case 1:
        case 2:
            if (_pitlen == 1) {
                if ([[_inputNum substringWithRange:NSMakeRange(_inputNum.length - 1, 1)] isEqualToString:@"0"]) {
                    _zheng = @"整";
                    break;
                }
            }
            else if (_pitlen == 2){
                if ([[_inputNum substringWithRange:NSMakeRange(_inputNum.length - 1, 1)] isEqualToString:@"0"] &&
                    [[_inputNum substringWithRange:NSMakeRange(_inputNum.length - 2, 1)] isEqualToString:@"0"]) {
                    _zheng = @"整";
                    break;
                }
            }
            
        default:
            for (int i = _pitlen; i >=1; i--) {
                NSString *_curNum = [_inputNum substringWithRange:NSMakeRange(_numlen-i, 1)];
                if (![_curNum isEqualToString:@"0"]) {
                    [_backStr appendString:_dArr[[_curNum intValue]]];
                    if (_pitlen == 1) {
                        [_backStr appendString:_pArr[1]];
                    }
                    else{
                        if (i == 2) {
                            [_backStr appendString:_pArr[1]];
                        }
                        else{
                            [_backStr appendString:_pArr[0]];
                        }
                    }
                    switch (i) {
                        case 2:
                            break;
                        case 1:
                            break;
                            
                        default:
                            break;
                    }
                }
            }
            break;
    }
    
    [_backStr appendString:_zheng];
    if (_backStr.length == 1) {
        return @"";
    }
    return _backStr;

}
- (BOOL)isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length]==0) {
        return YES;
    }
    return NO;
}

@end


