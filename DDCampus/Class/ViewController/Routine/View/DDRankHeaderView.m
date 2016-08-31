//
//  DDRankHeaderView.m
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRankHeaderView.h"

@implementation DDRankHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setNeedsLayout
{
    [super setNeedsLayout];
    CGFloat width = SCREEN_WIDTH/3;
    _firstLabel.frame = CGRectMake(0, 0, width, self.frame.size.height);
    _secondLabel.frame = CGRectMake(width, 0, width, self.frame.size.height);
    _thirdLabel.frame = CGRectMake(SCREEN_WIDTH-width, 0, width, self.frame.size.height);
}

- (void)setHeaderValue:(NSArray *)array
{
    _firstLabel.text = array[0];
    _secondLabel.text = array[1];
    _thirdLabel.text = array[2];
}
@end
