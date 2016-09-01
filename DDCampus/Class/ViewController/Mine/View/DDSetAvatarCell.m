//
//  DDSetAvatarCell.m
//  DDCampus
//
//  Created by wu on 16/8/10.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSetAvatarCell.h"

@implementation DDSetAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerView.layer.masksToBounds = YES;
    _headerView.layer.cornerRadius = _headerView.frame.size.width/2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
