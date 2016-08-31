//
//  UIImage+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Custom)

+ (UIImage *)stretchableImageNamed:(NSString *)imageName;
+ (UIImage *)resizableImageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets;
//中间拉伸
+ (UIImage *)stretchableCenterImageNamed:(NSString *)imageName;

//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

-(UIImage*)scaledToSize:(CGSize)newSize;

- (UIImage *)fixOrientation;

@end
