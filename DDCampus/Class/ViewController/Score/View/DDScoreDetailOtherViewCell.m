//
//  DDScoreDetailOtherViewCell.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreDetailOtherViewCell.h"

@implementation DDScoreDetailOtherViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(100);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(10);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
