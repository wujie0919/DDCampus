//
//  DDSelectClassInfoCell.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSelectClassInfoCell.h"

@implementation DDSelectClassInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGSize size = CGSizeMake(CGRectGetWidth(_selectView.frame), CGRectGetHeight(_selectView.frame));
    [_selectView setBackgroundImage:[UIImage imageWithColor:RGB(101, 200, 126) size:size] forState:UIControlStateHighlighted];
    [_selectView setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(id)sender {
    if (_sBlock) {
        _sBlock();
    }
}

@end
