//
//  DDRoutineWeekCell.m
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineWeekCell.h"

@implementation DDRoutineWeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _weekView = [[[NSBundle mainBundle] loadNibNamed:@"DDRoutineWeekView" owner:nil options:nil] lastObject];
    [self addSubview:_weekView];
    @WeakObj(self);
    [_weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
