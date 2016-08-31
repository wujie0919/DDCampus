//
//  NSData+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface NSData (Custom)

- (NSString *)toString;

- (id)objectFromJSONData;

- (NSData *) md5;
- (NSData *) sha1;

- (NSString *)base64Encoded;
- (NSData *)base64Decoded;


- (NSData *)encryptWithKey:(NSString *)key algorithm:(CCOptions)algorithm;
- (NSData *)decryptWithKey:(NSString *)key  algorithm:(CCOptions)algorithm;

- (NSData *)AESEncryptWithKey:(NSString *)key;
- (NSData *)AESDecryptWithKey:(NSString *)key;

- (NSData *)DESEncryptWithKey:(NSString *)key;
- (NSData *)DESDecryptWithKey:(NSString *)key;

- (NSData *)RSAEncryptWithPath:(NSString *)path;

@end
