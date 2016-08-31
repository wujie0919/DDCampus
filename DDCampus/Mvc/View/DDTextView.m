//
//  DDTextView.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTextView.h"

@implementation DDTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGB(217, 217, 217).CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

@end
