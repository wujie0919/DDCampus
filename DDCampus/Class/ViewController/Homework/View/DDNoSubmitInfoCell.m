//
//  DDNoSubmitInfoCell.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNoSubmitInfoCell.h"

@implementation DDNoSubmitInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _unSbumitView= [[[NSBundle mainBundle] loadNibNamed:@"DDNoSubmitInfoView" owner:nil options:nil] lastObject];
    [self addSubview:_unSbumitView];
    @WeakObj(self);
    [_unSbumitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak).insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
