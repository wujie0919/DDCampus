//
//  DDStudentScoreCollectionCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDStudentScoreCollectionCell.h"

@implementation DDStudentScoreCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _valueLabel.layer.masksToBounds = YES;
    _valueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _valueLabel.layer.borderWidth = 1;
    _valueLabel.layer.cornerRadius = 2;
    _valueLabel.backgroundColor = RGB(247, 248, 249);
    _valueLabel.userInteractionEnabled = NO;
}
- (void)setValue:(NSDictionary *)dic
{
    _valueLabel.text = [NSString stringWithFormat:@"%@：%@",dic[@"name"],dic[@"score"]];
}
@end
