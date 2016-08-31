//
//  DDGroupApplyTableCell.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupApplyTableCell.h"
#import "DDGroupSetManagerModel.h"

@implementation DDGroupApplyTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)cancelClick:(id)sender {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    _optButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _optButton.layer.borderWidth = 1;
    _optButton.layer.masksToBounds = YES;
    _optButton.layer.cornerRadius = 2;
}

- (void)setData:(DDGroupSetManagerModel *)model
{
    if (model.select) {
        _selectImageView.image = [UIImage imageNamed:@"member_select"];
    }
    else
    {
        _selectImageView.image = [UIImage imageNamed:@"member_normal"];
    }
    [_headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,model.pic] placeholder:nil];
    _nameLabel.text = model.nickname;
    if ([model.level integerValue] == 2) {
        _optButton.hidden = NO;
    }
    else
    {
        _optButton.hidden = YES;
    }
}

@end
