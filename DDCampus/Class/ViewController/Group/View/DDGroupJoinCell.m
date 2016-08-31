//
//  DDGroupJoinCell.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupJoinCell.h"

@implementation DDGroupJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @WeakObj(self);
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selfWeak.contentView).offset(10);
        make.top.equalTo(selfWeak.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selfWeak.headerView.mas_right).offset(10);
        make.top.equalTo(selfWeak.contentView).offset(25);
        make.bottom.equalTo(selfWeak.contentView).offset(-25);
        make.width.mas_equalTo(150);
    }];
    [_refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selfWeak.nickNameLabel.mas_right).offset(10);
        make.top.equalTo(selfWeak.contentView).offset(26);
        make.size.mas_equalTo(CGSizeMake(30, 49));
    }];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(selfWeak.contentView).offset(-15);
        make.top.equalTo(selfWeak.contentView).offset(26);
        make.size.mas_equalTo(CGSizeMake(30, 49));
    }];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(selfWeak.contentView).offset(-15);
        make.top.equalTo(selfWeak.contentView).offset(26);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    _refuseButton.layer.masksToBounds = YES;
    _refuseButton.layer.cornerRadius=5;
    _refuseButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _refuseButton.layer.borderWidth=1;
}

- (IBAction)refuseButtonClick:(id)sender{
    if (_handler) {
        _handler(1);
    }
}

- (IBAction)agreeButtonClick:(id)sender {
    if (_handler) {
        _handler(2);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue:(DDJoinModel *)joinModel
{
    [_headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,joinModel.pic] placeholder:nil];
    _nickNameLabel.text = joinModel.nickname;
    if ([joinModel.status integerValue]==1 || [joinModel.status integerValue]==2) {
        _refuseButton.hidden = YES;
        _agreeButton.hidden = YES;
        _infoLabel.hidden = NO;
        _infoLabel.text = [joinModel.status integerValue]==1?@"已拒绝":@"已同意";
    }
    else
    {
        _refuseButton.hidden = NO;
        _agreeButton.hidden = NO;
        _infoLabel.hidden = YES;
    }
}
@end
