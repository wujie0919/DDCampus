//
//  DDLeftViewTextField.m
//  DDCampus
//
//  Created by wu on 16/8/10.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDLeftViewTextField.h"

@implementation DDLeftViewTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGB(217, 217, 217).CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.leftView = view;
    self.leftViewMode=UITextFieldViewModeAlways;
}

@end
