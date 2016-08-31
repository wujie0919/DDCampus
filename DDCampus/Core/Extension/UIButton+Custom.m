//
//  UIButton+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

- (void)setAction:(void (^)(void))action{
    objc_setAssociatedObject(self, "ButtonAction", action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(ycbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ycbButtonAction:(UIButton *)button{
    void (^action)(void) = objc_getAssociatedObject(self, "ButtonAction");
    if (action) {
        action();
    }
}

@end
