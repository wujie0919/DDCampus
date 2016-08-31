//
//  NSObject+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSObject+Custom.h"

@implementation NSObject (Custom)
- (id)associatedObjectForKey:(const char *)key{
    return objc_getAssociatedObject(self, key);
}
- (void)setAssociatedObject:(id)object forkey:(const char *)key{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedBlockForKey:(const char *)key{
    return objc_getAssociatedObject(self, key);
}
- (void)setAssociatedBlock:(id)object forkey:(const char *)key{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id <NSObject>)registerNotification:(NSString *)name object:(id)obj usingBlock:(void (^)(NSNotification *note))block{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    return [notification addObserverForName:name object:obj queue:[NSOperationQueue currentQueue] usingBlock:block];
}

- (void)observeKeyboard{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [notification addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidShowNotification object:nil];
    [notification addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [notification addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)unObserveKeyboard{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [notification removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [notification removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [notification removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

//处理键盘通知
- (void)handleKeyboardNotification:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    //    CGRect beginFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSUInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        [self keyboardWillShow:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
        [self keyboardDidShow:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        [self keyboardWillHide:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
        [self keyboardDidHide:endFrame duration:duration curve:curve];
    }
}

- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardDidShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardDidHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
@end
