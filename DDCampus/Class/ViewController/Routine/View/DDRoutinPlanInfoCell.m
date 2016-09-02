//
//  DDRoutinPlanInfoCell.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinPlanInfoCell.h"

@implementation DDRoutinPlanInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_zhizhouLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(0);
        make.height.mas_equalTo(20);
    }];
    [_fuzelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhizhouLable).offset(10);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(20);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSDictionary *)dic
{
    _zhizhouLable.text = [NSString stringWithFormat:@"值周人：%@",dic[@"student_name"]];
    _fuzelabel.text = [NSString stringWithFormat:@"负责班级：%@",dic[@"classallitem"]];
    _height = CGRectGetMaxY(_fuzelabel.frame);
}

@end
