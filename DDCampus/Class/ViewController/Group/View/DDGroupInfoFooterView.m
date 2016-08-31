//
//  DDGroupInfoFooterView.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupInfoFooterView.h"

@implementation DDGroupInfoFooterView

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newmessageClick)];
    [_bgView addGestureRecognizer:tap];
    _valueLabel.textColor = RGB(101, 200, 126);
    _exitButton.layer.masksToBounds = YES;
    _exitButton.layer.cornerRadius = 5;
    _exitButton.backgroundColor = RGB(101, 200, 126);
}

- (void)newmessageClick
{
    if (_mBlock) {
        _mBlock();
    }
}

@end
