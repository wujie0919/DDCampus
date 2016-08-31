//
//  DDSubmitValueCell.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSubmitValueCell.h"

@implementation DDSubmitValueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    @WeakObj(self);
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak).offset(0);
//        make.width.offset(120);
//        make.left.equalTo(selfWeak).offset(0);
//        make.bottom.equalTo(selfWeak).offset(0);
//    }];
//    _nameLabel.backgroundColor = [UIColor blueColor];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak).offset(0);
//        make.left.equalTo(selfWeak.nameLabel.mas_left).offset(0);
//        make.bottom.equalTo(selfWeak).offset(0);
//        make.width.offset(180);
//    }];
//    _timeLabel.backgroundColor = [UIColor greenColor];
//    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak).offset(0);
//        make.left.equalTo(selfWeak.timeLabel.mas_right).offset(0);
//        make.right.equalTo(selfWeak).offset(0);
//        make.bottom.equalTo(selfWeak).offset(0);
//    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue:(NSDictionary *)dic
{
    _nameLabel.text = dic[@"name"];
    _timeLabel.text = [NSDate getDateValue:dic[@"done_dateline"]];
    _weekLabel.text = [NSDate getDayValue:dic[@"done_dateline"]];
}
@end
