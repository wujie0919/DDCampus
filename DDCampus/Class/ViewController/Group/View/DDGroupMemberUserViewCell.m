//
//  DDGroupMemberUserViewCell.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupMemberUserViewCell.h"

@implementation DDGroupMemberUserViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSDictionary *)dic
{
    [_headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"pic"]] placeholder:@"usericon"];
    _nameLabel.text = dic[@"nickname"];
}

@end
