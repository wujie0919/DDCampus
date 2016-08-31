//
//  UITextField+Custom.m
//  YCBiOSClient
//
//  Created by Pan Lee on 16/1/6.
//  Copyright © 2016年 ycb. All rights reserved.
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

- (void)addCustomToolbar
{
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 38.0f)];
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, RGB(51, 51, 51).CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [keyboardToolbar setBackgroundImage:image
                         forToolbarPosition:UIBarPositionAny
                                 barMetrics:UIBarMetricsDefault];
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    
    __block typeof(self) wself = self;
    [button setAction:^{
        [wself resignFirstResponder];
    }];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake(0, 0, 38.0f, 38.0f);
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [keyboardToolbar setItems:@[spaceBarItem,doneBarItem]];
    [self setInputAccessoryView:keyboardToolbar];
}

@end
