//
//  DDMineHelpCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMineHelpCell.h"

@implementation DDMineHelpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _helpView = [[[NSBundle mainBundle] loadNibNamed:@"DDHelpView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_helpView];
    [_helpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
