//
//  DDHomeImageCell.m
//  DDCampus
//
//  Created by wu on 16/8/23.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeImageCell.h"

@implementation DDHomeImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _scrollImageView  = [[[NSBundle mainBundle] loadNibNamed:@"DDScrollImageView" owner:nil options:nil] lastObject];
    [self addSubview:_scrollImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
