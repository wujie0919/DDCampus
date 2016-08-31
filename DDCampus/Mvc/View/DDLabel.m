//
//  DDLabel.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDLabel.h"

@implementation DDLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (void)awakeFromNib
{
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *buttonLayer = [[CAShapeLayer alloc]init];
    buttonLayer.frame = self.bounds;
    buttonLayer.borderColor = RGB(217, 217, 217).CGColor;
    buttonLayer.path = buttonPath.CGPath;
    self.layer.mask = buttonLayer;
}


@end
