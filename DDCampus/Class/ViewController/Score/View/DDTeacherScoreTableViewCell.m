//
//  DDTeacherScoreTableViewCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTeacherScoreTableViewCell.h"

@implementation DDTeacherScoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _nameView.layer.masksToBounds = YES;
    _nameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nameView.layer.borderWidth = 1;
    _nameView.layer.cornerRadius = 2;
    _nameView.backgroundColor = RGB(247, 248, 249);
    _nameView.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data
{
    _dic = data;
    [_nameView setTitle:data[@"name"] forState:UIControlStateNormal];
    NSString *max = [NSString stringWithFormat:@"%d",[data[@"max"] integerValue]];
    _maxLabel.text = [NSString stringWithFormat:@"最高分 %@",max];
    NSString *min = [NSString stringWithFormat:@"%d",[data[@"min"] integerValue]];
    _minLabel.text = [NSString stringWithFormat:@"最低分 %@",min];
    NSString *avg = [NSString stringWithFormat:@"%d",[data[@"avg"] integerValue]];
    _avgLabel.text = [NSString stringWithFormat:@"平均分 %@",avg];
}
@end
