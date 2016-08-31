//
//  UIView+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)

- (void)setCorner:(CGFloat)corner;
- (void)setBorder:(CGFloat)border color:(UIColor *)color;
- (void)setShadow:(CGSize)offset corner:(CGFloat)corner opacity:(CGFloat)opacity color:(UIColor *)color;

@end
