//
//  DDHomeworkCell.m
//  DDCampus
//
//  Created by wu on 16/8/13.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeworkCell.h"
#import "DDHomeworkModel.h"

@implementation DDHomeworkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(DDHomeworkModel *)homeworkModel row:(NSInteger)row
{
    NSInteger type = [appDelegate.userModel.type integerValue];
    _title_label.text = homeworkModel.homework_title;
    
   NSString *status = @"";
    if ([homeworkModel.homework_isdone isEqualToString:@"1"]) {
        status = type==1?@"已完成":@"已提交";
    }
    else if ([homeworkModel.homework_isdone isEqualToString:@"0"]) {
        status = type==1?@"未完成":@"未提交";
    }
    _status_label.text = status;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",homeworkModel.homework_content]
                                                                               attributes:@{
                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                            
                                                                                            }];
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _content_label.attributedText = content;
    CGFloat heihgt = textSize.height;
    if (textSize.height>50) {
        heihgt = 50;
    }
    _content_label.frame = CGRectMake(_title_label.frame.origin.x,_title_label.frame.size.height+_title_label.frame.origin.x,SCREEN_WIDTH-20,heihgt);
    
    _teacher_label.text = homeworkModel.homework_teacher_name;
    _teacher_label.frame = CGRectMake(_title_label.frame.origin.x, _content_label.frame.origin.y+_content_label.frame.size.height+10, 110, 20);
    _time_label.text = [NSDate getDateValue:homeworkModel.homework_dateline];
    _time_label.frame = CGRectMake(_teacher_label.frame.origin.x+_teacher_label.frame.size.width, _content_label.frame.origin.y+_content_label.frame.size.height+10, 130, 20);
    _week_label.text = [NSDate getDayValue:homeworkModel.homework_dateline];
    _week_label.frame = CGRectMake(_status_label.frame.origin.x, _content_label.frame.origin.y+_content_label.frame.size.height+10, _status_label.frame.size.width, 20);
    if (row%2>0 && row>0) {
        _colorLabel.backgroundColor = RGB(237, 238, 239);
        _colorLabel.frame = CGRectMake(0, _teacher_label.frame.origin.y+30, SCREEN_WIDTH, 10);
        _height = _colorLabel.frame.origin.y+_colorLabel.frame.size.height;
    }else{
        _colorLabel.backgroundColor = RGB(237, 238, 239);
        _colorLabel.frame = CGRectMake(0, _teacher_label.frame.origin.y+30, SCREEN_WIDTH, 1);
        _height = _colorLabel.frame.origin.y+_colorLabel.frame.size.height;
    }
    
}


@end
