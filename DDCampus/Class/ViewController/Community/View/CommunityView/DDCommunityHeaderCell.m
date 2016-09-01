//
//  DDCommunityHeaderCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityHeaderCell.h"

@implementation DDCommunityHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
    _lineLabel.backgroundColor =  RGB(101, 200, 126);
    @WeakObj(self);
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(0);
        make.right.equalTo(selfWeak).offset(0);
        make.height.mas_equalTo(20);
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selfWeak).offset(-2);
        make.left.equalTo(selfWeak).offset(0);
        make.right.equalTo(selfWeak).offset(0);
        make.height.mas_equalTo(2);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(DDCommounityModel *)model
{
    _valueLabel.text = model.name;
    if (model.select) {
        _lineLabel.hidden = NO;
    }
    else
    {
        _lineLabel.hidden = YES;
    }
}

@end
