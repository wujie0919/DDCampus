//
//  DDFindGroupCollectionViewCell.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDFindGroupCollectionViewCell.h"
#import "DDFindGroupModel.h"

@interface DDFindGroupCollectionViewCell ()

@end

@implementation DDFindGroupCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titeButton.layer.masksToBounds = YES;
    _titeButton.layer.cornerRadius = 5;
    _titeButton.layer.borderWidth = 1;
    _titeButton.userInteractionEnabled = NO;
}
- (void)setData:(DDFindGroupModel *)model
{
    if (model.isSelect) {
        [_titeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _titeButton.backgroundColor = RGB(101, 200, 126);
        _titeButton.layer.borderColor = RGB(101, 200, 126).CGColor;
    }
    else
    {
        [_titeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _titeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titeButton.backgroundColor = [UIColor whiteColor];
    }
    
    [_titeButton setTitle:model.title forState:UIControlStateNormal];
}

@end
