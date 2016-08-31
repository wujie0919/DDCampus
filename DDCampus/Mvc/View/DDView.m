//
//  DDView.m
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDView.h"

@implementation DDView

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
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
}
- (void)setNeedsLayout
{
    [super setNeedsLayout];
//    [self setButtonStyle];
}

- (void)setButtonStyle
{
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *buttonLayer = [[CAShapeLayer alloc]init];
    buttonLayer.frame = self.bounds;
    buttonLayer.path = buttonPath.CGPath;
    
//    self.backgroundColor = RGB(101, 200, 126);
}

@end
