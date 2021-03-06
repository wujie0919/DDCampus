//
//  NSString+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Regex_Null          @"/s"                       // 空字符
#define Regex_NotNull       @"/S"                       // 非空字符

#define Regex_Sign          @"^\\p{Punct}$"             // 符号字符
#define Regex_AllSign       @"^\\p{Punct}+$"            // 全部符号

#define Regex_Number        @"^\\d{1}$"                 // 数字字符
#define Regex_AllNumber     @"^\\d+$"                   // 全部数字

#define Regex_Char          @"^[A-Za-z]$"               // 字母字符
#define Regex_AllChar       @"^[A-Za-z]+$"              // 全部字母

#define Regex_China         @"^[\\u4E00-\\u9FA5]$"      // 中文字符
#define Regex_AllChina      @"^[\\u4E00-\\u9FA5]+$"     // 全部字符

// 用户账号
#define Regex_UserName      @"^[A-Za-z0-9]{6,32}$"

// 用户密码
#define Regex_Password      @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"

// 用户卡号
#define Regex_CardNO        @"^[A-Za-z0-9]+$"

// 港澳能行证
#define Regex_GanAoCard     @"^(H|M)\\d{10}$"

// 台胞证
#define Regex_TaiWanCard    @"^\\d{10}(\\([A-Za-z]{1}\\))|(\\(\\d{2}\\))$"

// 身份证号
#define Regex_18IDCard      @"^[1-9]\\d{5}[1-9]\\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|3[0-1])\\d{3}(\\d|X|x)$"
#define Regex_15IDCard      @"^[1-9]\\d{5}[1-9]\\d((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|3[0-1])\\d{3}$"
#define Regex_IDCard        @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)*"

// 网址地址
#define Regex_Url           @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"

// 电子邮件
#define Regex_Email         @"^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$"

// 座机号码
#define Regex_Telephone     @"(\\(\\d{3,4}\\)|\\d{3,4}-|\\s)?\\d{6,14}"

// 手机号码
#define Regex_Mobilephone   @"^1(3\\d|5[0-35-9]|8[0-9]|7\\d)\\d{8}$"
//#define Regex_Mobilephone   @"^1(3\\d|5[0-35-9]|8[025-9]|7\\d)\\d{8}$"

//#define Regex_Mobilephone   @"^((\\+86)|(\\+86 )|(86)|(86 ))?(13[0-9]|14[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"

// 移动号码段（134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、187、188）
#define Regex_CMCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(3[4-9]|47|5[012789]|8[2378])\\d{8}$"

// 联通号码段（130、131、132、155、156、185、186）
#define Regex_CUCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(3[0-2]|5[56]|8[56])\\d{8}$"

// 电信号码段（133、153、180、189）
#define Regex_CTCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(33|53|8[09])\\d{8}$"

// 验证码
#define Regex_MobilephoneCoede   @"^\\d{6}$"

@interface NSString (Custom)

- (id)objectFromJSONString;
- (NSData *)toData;
- (UIColor *)toColor;
- (NSDate *)dateWithFormate:(NSString *)formate;

- (NSString *)MD5;
- (NSString *)SHA1;
- (NSString *)hmacSHA1:(NSString *)key;
- (NSString *)hmacSHA256:(NSString *)key;
- (NSString *)hmacMD5:(NSString *)key;

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;
- (BOOL)isNumberOfDecimal:(NSUInteger)length;
- (BOOL)isTelephone;
- (BOOL)isIdCard;
- (BOOL)isMobilphone;
- (BOOL)isMobilphoneCode;
- (BOOL)isUserName;
- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isUrl;

- (BOOL)isBlankString;

- (CGSize)sizeWithFont:(UIFont *)font destSize:(CGSize)destSize;
- (CGSize)getAttrbutedStringSizeWithmaxSize:(CGSize)max_size font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

// 数字转汉字大写
- (NSString *)capitalFormChineseNumeral;
- (NSMutableAttributedString *)getAttributedStringWithfont:(UIFont *)font color:(UIColor *)color lineSpace:(float)lineSpace alignment:(NSTextAlignment)alignment;


@end
