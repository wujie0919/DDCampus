//
//  DDCommunityCell.m
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityCell.h"

@implementation DDCommunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue:(NSString *)text count:(NSInteger)count
{
    NSMutableAttributedString *textImage = [NSMutableAttributedString new];
    NSAttributedString *issueContent = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [textImage appendAttributedString:issueContent];
    CGSize textSize = [textImage boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _valueLabel.attributedText = textImage;
    if (count<=3) {
        _valueLabel.frame = CGRectMake(0, 0,SCREEN_WIDTH/3,44);
        _height = SCREEN_WIDTH/3;
    }else{
        _valueLabel.frame = CGRectMake(0, 0,textSize.width+30,44);
        _height = textSize.width+30;
    }
}

@end
