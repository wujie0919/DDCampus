//
//  DDButton.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDButton.h"

@implementation DDButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [self setButtonStyle];
}

- (void)setButtonStyle
{
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *buttonLayer = [[CAShapeLayer alloc]init];
    buttonLayer.frame = self.bounds;
    buttonLayer.path = buttonPath.CGPath;
    self.layer.mask = buttonLayer;
    self.backgroundColor = RGB(101, 200, 126);
}


@end
