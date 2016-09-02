//
//  DDRoutinePlanCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinePlanCell.h"

@implementation DDRoutinePlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _planView = [[[NSBundle mainBundle] loadNibNamed:@"DDRoutinePlanView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_planView];
    @WeakObj(self);
    [_planView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak.contentView).offset(0);
//        make.right.equalTo(selfWeak.contentView).offset(0);
//        make.left.equalTo(selfWeak.contentView).offset(0);
//        make.bottom.equalTo(selfWeak.contentView).offset(-10);
        make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
