//
//  DDMessageView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMessageView.h"

@implementation DDMessageView

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
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.left.equalTo(selfWeak).offset(10);
        make.height.mas_equalTo(220);
    }];
    
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(5);
        make.right.equalTo(selfWeak).offset(-10);
        make.height.mas_equalTo(CGSizeMake(100, 20));
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(15);
        make.right.equalTo(selfWeak).offset(-10);
        make.left.equalTo(selfWeak).offset(10);
        make.bottom.equalTo(selfWeak).offset(-25);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(selfWeak).offset(-10);
        make.bottom.equalTo(selfWeak).offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
}

- (void)setData:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic[@"ptype"]integerValue]==2) {
            _classLabel.hidden = NO;
        }
        else
        {
            _classLabel.hidden = YES;
        }
        _nameLabel.text = dic[@"subject"];
        _messageLabel.text = dic[@"message"];
        _dateLabel.text = [NSDate getDateValue:dic[@"dateline"]];
        _height = CGRectGetMaxY(_dateLabel.frame);
    }
}
@end
