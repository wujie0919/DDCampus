//
//  TransferGroupCell.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "TransferGroupCell.h"
#import "DDGroupSetManagerModel.h"

@implementation TransferGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(DDGroupSetManagerModel *)model
{
    if (model.select) {
        _selectView.image = [UIImage imageNamed:@"member_select"];
    }
    else
    {
        _selectView.image = [UIImage imageNamed:@"member_normal"];
    }
    [_headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,model.pic] placeholder:nil];
    _nameLabel.text = model.nickname;
}
@end
