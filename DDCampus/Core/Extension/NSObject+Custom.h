//
//  NSObject+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Custom)
- (id)associatedObjectForKey:(const char *)key;
- (void)setAssociatedObject:(id)object forkey:(const char *)key;

- (id)associatedBlockForKey:(const char *)key;
- (void)setAssociatedBlock:(id)object forkey:(const char *)key;

- (id <NSObject>)registerNotification:(NSString *)name object:(id)obj usingBlock:(void (^)(NSNotification *note))block;

- (void)observeKeyboard;
- (void)unObserveKeyboard;

- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardDidShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardDidHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
@end
