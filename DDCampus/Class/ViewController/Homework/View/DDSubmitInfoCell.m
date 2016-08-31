//
//  DDSubmitInfoCell.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSubmitInfoCell.h"


@implementation DDSubmitInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _submitInfoView = [[[NSBundle mainBundle] loadNibNamed:@"DDSubmitInfoView" owner:nil options:nil] lastObject];
    [self addSubview:_submitInfoView];
    @WeakObj(self);
    [_submitInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(selfWeak).insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
