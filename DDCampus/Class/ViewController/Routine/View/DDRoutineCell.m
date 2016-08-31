//
//  DDRoutineCell.m
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineCell.h"

@implementation DDRoutineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dayView = [[[NSBundle mainBundle] loadNibNamed:@"DDRoutineDayView" owner:nil options:nil] lastObject];
    [self addSubview:_dayView];
    @WeakObj(self);
    [_dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
