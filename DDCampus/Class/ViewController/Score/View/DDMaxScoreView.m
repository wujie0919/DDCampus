//
//  DDMaxScoreView.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMaxScoreView.h"

@implementation DDMaxScoreView

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
}
- (IBAction)changeValue:(id)sender {
    if ([_scoreText.text isEqualToString:@"100"]) {
        _manLabel.textColor = [UIColor hexString:@"#f26f10"];
        _scoreText.textColor = [UIColor hexString:@"#f26f10"];
    }
    else
    {
        _manLabel.textColor = [UIColor hexString:@"#bababa"];
        _scoreText.textColor = [UIColor hexString:@"#bababa"];
    }
    if ([_scoreText.text integerValue]>100) {
        [MBProgressHUD showError:@"成绩输入错误，请重新输入"];
        _scoreText.text = @"";
        return ;
    }
    if (_changeBlock) {
        _changeBlock(_scoreText.text,_scoreText.tag);
    }
}
@end
