//
//  DDTrendView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTrendView.h"

@implementation DDTrendView

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
    _avgView.layer.masksToBounds = YES;
    _avgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _avgView.layer.borderWidth = 1;
    _avgView.layer.cornerRadius = 2;
    _avgView.backgroundColor = RGB(247, 248, 249);
    _avgView.userInteractionEnabled = NO;
    
    _maxView.layer.masksToBounds = YES;
    _maxView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _maxView.layer.borderWidth = 1;
    _maxView.layer.cornerRadius = 2;
    _maxView.backgroundColor = RGB(247, 248, 249);
    _maxView.userInteractionEnabled = NO;
    
    _minView.layer.masksToBounds = YES;
    _minView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _minView.layer.borderWidth = 1;
    _minView.layer.cornerRadius = 2;
    _minView.backgroundColor = RGB(247, 248, 249);
    _minView.userInteractionEnabled = NO;
}
- (void)setData:(NSDictionary *)dic
{
    _nameLabel.text = dic[@"name"];
    [_avgView setTitle:[NSString stringWithFormat:@"平均分：%@",dic[@"avg"]] forState:UIControlStateNormal];
    [_maxView setTitle:[NSString stringWithFormat:@"最高分：%@",dic[@"max"]] forState:UIControlStateNormal];
    [_minView setTitle:[NSString stringWithFormat:@"最高分：%@",dic[@"min"]] forState:UIControlStateNormal];
}
@end
