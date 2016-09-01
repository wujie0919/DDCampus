//
//  DDScoreTrendCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreTrendCell.h"

@implementation DDScoreTrendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _trendView = [[[NSBundle mainBundle] loadNibNamed:@"DDTrendView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_trendView];
    @WeakObj(self);
    [_trendView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
