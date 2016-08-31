//
//  DDRoutineWeekView.m
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineWeekView.h"
#import "DDClassweekpointModel.h"

@implementation DDRoutineWeekView

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
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.width.offset(220);
        make.height.offset(20);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(15);
        make.right.equalTo(selfWeak).offset(-10);
        make.width.offset(120);
        make.height.offset(15);
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.width.offset(80);
        make.height.offset(20);
    }];
    [_rankingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.scoreLabel.mas_right).offset(5);
        make.width.offset(100);
        make.height.offset(20);
    }];
    _rankingLabel.backgroundColor = RGB(101, 200, 126);
    _rankingLabel.layer.masksToBounds = YES;
    _rankingLabel.layer.cornerRadius=2;
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.width.offset(100);
        make.height.offset(20);
    }];
    [_pointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.rankingLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.width.offset(60);
        make.height.offset(10);
    }];
    _font = [UIFont systemFontOfSize:12];
    [_detailsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.rankingLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.pointsLabel.mas_right).offset(0);
        make.width.offset(200);
        make.height.offset(10);
    }];
}

- (void)setWeekData:(DDClassweekpointModel *)model
{
    _titleLabel.text = model.weekname;
    _dateLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate getMonthAndDay:model.startday],[NSDate getMonthAndDay:model.endday]];
    _scoreLabel.text = [NSString stringWithFormat:@"评分：%@分",model.points];
    _rankingLabel.text = [NSString stringWithFormat:@"当前排名:第%@名",model.cursort];
    _classLabel.text = model.class_name;
    _pointsLabel.text = @"扣分详情:";
    
    @WeakObj(self);
    NSMutableAttributedString *textImage = [NSMutableAttributedString new];
    textImage.yy_lineSpacing = 5;
    if (model.showAll) {
        _showLabel.text = @"收起内容";
        _showLabel.hidden = NO;
        for (int i=0; i<model.cut_subject.count; i++) {
            NSDictionary *dic = model.cut_subject[i];
            NSString *content = [NSString stringWithFormat:@"%@,%@,%@",[NSDate getDayValue:dic[@"dateline"]],dic[@"subject"],dic[@"remark"]];
            if ([content hasSuffix:@","]) {
                content = [content substringToIndex:content.length-1];
            }
            NSAttributedString *issueContent = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:_font}];
            [textImage appendAttributedString:issueContent];
            [textImage appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
        }
    }else
    {
        if (model.cut_subject.count>3) {
            for (int i=0; i<3; i++) {
                NSDictionary *dic = model.cut_subject[i];
                NSString *content = [NSString stringWithFormat:@"%@,%@,%@",[NSDate getDayValue:dic[@"dateline"]],dic[@"subject"],dic[@"remark"]];
                if ([content hasSuffix:@","]) {
                    content = [content substringToIndex:content.length-1];
                }
                NSAttributedString *issueContent = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:_font}];
                [textImage appendAttributedString:issueContent];
                [textImage appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
            }
            //显示展示按钮
            _showLabel.hidden = NO;
        }else
        {
             _showLabel.hidden = YES;
            for (NSDictionary *dic in model.cut_subject) {
                NSString *content = [NSString stringWithFormat:@"%@,%@,%@",[NSDate getDayValue:dic[@"dateline"]],dic[@"subject"],dic[@"remark"]];
                if ([content hasSuffix:@","]) {
                    content = [content substringToIndex:content.length-1];
                }
                NSAttributedString *issueContent = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:_font}];
                [textImage appendAttributedString:issueContent];
                [textImage appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
            }
           
        }
    }
    CGSize textSize = [textImage boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _detailsLabel.attributedText = textImage;
    [_detailsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.rankingLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.pointsLabel.mas_right).offset(0);
        make.width.offset(200);
        make.height.offset(textSize.height);
    }];
    _height = CGRectGetMaxY(_rankingLabel.frame)+textSize.height+10;
    if (!_showLabel.hidden) {
        [_showLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.detailsLabel.mas_bottom).offset(0);
            make.left.offset(70);
            make.width.offset(100);
            make.height.offset(20);
        }];
        _showLabel.userInteractionEnabled = YES;
        _height = _height+25;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        [_showLabel addGestureRecognizer:labelTapGestureRecognizer];
    }
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer
{
    if (_handler) {
        _handler();
    }
}
@end
