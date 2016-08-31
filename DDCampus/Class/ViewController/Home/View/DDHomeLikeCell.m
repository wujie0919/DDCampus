//
//  DDHomeLikeCell.m
//  DDCampus
//
//  Created by wu on 16/8/24.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeLikeCell.h"

@interface DDHomeLikeCell ()

@property (nonatomic, strong) UIImage *likeImage;

@end

@implementation DDHomeLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    _likeImage = [UIImage imageNamed:@"like"];
    _contentLabel.textColor = RGB(101, 200, 126);
    _zanImageView.frame = CGRectMake(2, 5, 15, 15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLikeContent:(NSString *)text showLine:(BOOL)flg
{
    text = [text stringByReplacingOccurrencesOfString:LikeStartValue withString:@""];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",text]
                                                                               attributes:@{
                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                            
                                                                                            }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-90, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _contentLabel.attributedText = content;
    _height = textSize.height+10;
    if (_height<30) {
        _height = 30;
    }
    _contentLabel.frame = CGRectMake(20, 5, SCREEN_WIDTH-90, textSize.height);
    _lineLabel.hidden = flg;
    _lineLabel.frame = CGRectMake(0, _height-1, self.frame.size.width, 1);
}

@end
