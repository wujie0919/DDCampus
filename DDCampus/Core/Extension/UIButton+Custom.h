//
//  UIButton+Custom.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)
- (void)setAction:(void (^)(void))action;
@end
