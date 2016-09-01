//
//  DDMessageCell.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMessageCell.h"


@implementation DDMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _msgView = [[[NSBundle mainBundle] loadNibNamed:@"DDMessageView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:_msgView];
    @WeakObj(self);
    [_msgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
