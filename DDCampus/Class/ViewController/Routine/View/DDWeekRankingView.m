//
//  DDWeekRankingView.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDWeekRankingView.h"

@implementation DDWeekRankingView

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
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(10);
        make.size.mas_offset(CGSizeMake(120, 44));
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(110, 44));
    }];
    [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-10);
        make.size.mas_offset(CGSizeMake(60, 44));
    }];
}
- (void)setCellData:(id)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _nameLabel.text = dic[@"class_name"];
        _scoreLabel.text = [NSString stringWithFormat:@"%@",dic[@"points"]];
        _rankLabel.text = [NSString stringWithFormat:@"%@",dic[@"cursort"]];
    }
    if ([dic isKindOfClass:[NSArray class]]) {
        _nameLabel.text = dic[0];
        _scoreLabel.text =  dic[1];
        _rankLabel.text =  dic[2];
    }
}
@end
