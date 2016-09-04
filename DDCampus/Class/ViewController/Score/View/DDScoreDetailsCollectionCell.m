//
//  DDScoreDetailsCollectionCell.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreDetailsCollectionCell.h"

@implementation DDScoreDetailsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _nameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nameLabel.layer.cornerRadius = 2;
    _nameLabel.layer.borderWidth = 1;
    _nameLabel.layer.masksToBounds = YES;
}

- (void)setNameValue:(NSDictionary *)dict
{
    _nameLabel.text = [NSString stringWithFormat:@"%@:%@",dict[@"name"],dict[@"score"]];
}
@end
