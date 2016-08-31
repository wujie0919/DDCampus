//
//  DDHomeWorkDetailsCell.m
//  DDCampus
//
//  Created by wu on 16/8/17.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeWorkDetailsCell.h"
#import "DDHomeworkDetailsModel.h"

@implementation DDHomeWorkDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _homework_contentLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailsValue:(DDHomeworkDetailsModel *)model
{
    if (model) {
        _homework_titleLabel.text = model.title;
        _homework_teacherLabel.text = model.teacher_name;
        _homework_timeLabel.text = [model.dateline isValidString]?[NSDate getDateValue:model.dateline]:@"";
        _homework_weekLabel.text = [model.dateline isValidString]?[NSDate getDayValue:model.dateline]:@"";
        if ([model.content isValidString]) {
            NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.content]
                                                                                       attributes:@{
                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:13]
                                                                                                    
                                                                                                    }];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:2];
            [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
            CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            _homework_contentLabel.attributedText = content;
            @WeakObj(self);
            [_homework_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(selfWeak.homework_teacherLabel.mas_bottom).offset(10);
                make.left.equalTo(selfWeak).offset(selfWeak.homework_teacherLabel.frame.origin.x);
                make.size.mas_equalTo(CGSizeMake(textSize.width, textSize.height));
            }];
            [_homework_contentLabel sizeToFit];
//            _homework_contentLabel.frame = CGRectMake(10, self.homework_teacherLabel.frame.origin.y+self.homework_teacherLabel.frame.size.height, SCREEN_WIDTH-20, textSize.height);
            _homework_contentLabel.backgroundColor = [UIColor redColor];
            _height = _homework_contentLabel.frame.origin.y+textSize.height+10;
        }else
            _height = self.homework_teacherLabel.frame.origin.y+self.homework_teacherLabel.frame.size.height+10;
    }
}
@end
