//
//  DDCommentCell.m
//  DDCampus
//
//  Created by wu on 16/8/24.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommentCell.h"

@implementation DDCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _label = [YYLabel new];
    [self addSubview:_label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLabelValue:(NSString *)nickName content:(NSString *)text
{
    
}
@end
