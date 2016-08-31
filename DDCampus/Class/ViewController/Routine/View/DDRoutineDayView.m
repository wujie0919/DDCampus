//
//  DDRoutineDayView.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineDayView.h"

@implementation DDRoutineDayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    @WeakObj(self);
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
        make.left.equalTo(selfWeak).offset(10);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
}

- (void)setDayValue:(NSDictionary *)dic
{
    NSInteger sort = [dic[@"sort"] integerValue];
    NSString *day = @"";
    switch (sort) {
        case 1:
            day = @"周一";
            break;
        case 2:
            day = @"周二";
            break;
        case 3:
            day = @"周三";
            break;
        case 4:
            day = @"周四";
            break;
        case 5:
            day = @"周五";
            break;
        default:
            break;
    }
    _weekLabel.text = day;
    @WeakObj(self);
    NSMutableString *student_name = [NSMutableString new];
    if ([dic[@"student_name"]isKindOfClass:[NSArray class]]) {
       
        for (NSString *name in dic[@"student_name"]) {
            [student_name appendFormat:@"%@、",name];
        }
    }
    _height = CGRectGetMaxY(_weekLabel.frame)+10;
    if (student_name.length>0) {
        NSString *name = [student_name substringToIndex:student_name.length-1];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",name]
                                                                                   attributes:@{
                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                                                                
                                                                                                }];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [name length])];
        CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        _studentLabel.attributedText = content;
        [_studentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.weekLabel.mas_bottom).offset(10);
            make.left.equalTo(selfWeak).offset(10);
            make.right.equalTo(selfWeak).offset(-100);
            make.height.offset(textSize.height);
        }];
        _height = _studentLabel.frame.origin.y+textSize.height;
    }
    if ([dic[@"remark"] isValidString]) {
        _remarkLabe.hidden = NO;
        NSString *remark = dic[@"remark"];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",remark]
                                                                                   attributes:@{
                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                                                                
                                                                                                }];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [remark length])];
        CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-110, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        _remarkLabe.attributedText = content;
        [_remarkLabe mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.studentLabel.mas_bottom).offset(10);
            make.left.equalTo(selfWeak).offset(10);
            make.right.equalTo(selfWeak).offset(-100);
            make.height.offset(textSize.height);
        }];
        _height = _height+10+textSize.height;
    }
}

@end
