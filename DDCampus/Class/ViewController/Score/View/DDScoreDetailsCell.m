//
//  DDScoreDetailsCell.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreDetailsCell.h"

@implementation DDScoreDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _detailsView = [[[NSBundle mainBundle] loadNibNamed:@"DDScoreDetailsView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_detailsView];
    @WeakObj(self);
    [_detailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
