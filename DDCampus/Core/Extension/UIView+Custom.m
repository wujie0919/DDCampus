//
//  UIView+Custom.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

- (void)setCorner:(CGFloat)corner{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:corner];
}

- (void)setBorder:(CGFloat)border color:(UIColor *)color{
    [self.layer setBorderWidth:border];
    [self.layer setBorderColor:color.CGColor];
}

- (void)setShadow:(CGSize)offset corner:(CGFloat)corner opacity:(CGFloat)opacity color:(UIColor *)color{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowPath:shadowPath.CGPath];
}

@end
