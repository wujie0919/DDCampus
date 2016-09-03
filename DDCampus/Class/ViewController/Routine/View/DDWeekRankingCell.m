//
//  DDWeekRankingCell.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDWeekRankingCell.h"

@implementation DDWeekRankingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _rankView = [[[NSBundle mainBundle] loadNibNamed:@"DDWeekRankingView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_rankView];
    @WeakObj(self);
    [_rankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
