//
//  DDTeacherScoreView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTeacherScoreView.h"

@implementation DDTeacherScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nameLabel.layer.borderWidth = 1;
    _nameLabel.layer.cornerRadius = 2;
    _nameLabel.backgroundColor = RGB(247, 248, 249);
    _nameLabel.userInteractionEnabled = NO;
}
- (void)setData:(NSDictionary *)data
{
    _nameLabel.text = data[@"name"];
    NSString *max = [NSString stringWithFormat:@"%ld",[data[@"max"] integerValue]];
    _maxLabel.text = [NSString stringWithFormat:@"最高分 %@",max];
    NSString *min = [NSString stringWithFormat:@"%ld",[data[@"min"] integerValue]];
    _minLabel.text = [NSString stringWithFormat:@"最低分 %@",min];
    NSString *avg = [NSString stringWithFormat:@"%ld",[data[@"avg"] integerValue]];
    _avgLabel.text = [NSString stringWithFormat:@"平均分 %@",avg];
}
@end
