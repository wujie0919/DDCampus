//
//  DDRankCell.m
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRankCell.h"

@implementation DDRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    CGFloat width = SCREEN_WIDTH/3;
    _classLabel.frame = CGRectMake(0, 0, width, self.frame.size.height);
    _scoreLabel.frame = CGRectMake(width, 0, width, self.frame.size.height);
    _rankLabel.frame = CGRectMake(SCREEN_WIDTH-width, 0, width, self.frame.size.height);
}

@end
