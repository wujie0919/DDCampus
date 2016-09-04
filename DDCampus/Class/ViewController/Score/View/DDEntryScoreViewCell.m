//
//  DDEntryScoreViewCell.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDEntryScoreViewCell.h"

@implementation DDEntryScoreViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _entryView = [[[NSBundle mainBundle] loadNibNamed:@"DDEntryScoreView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_entryView];
    @WeakObj(self);
    [_entryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
