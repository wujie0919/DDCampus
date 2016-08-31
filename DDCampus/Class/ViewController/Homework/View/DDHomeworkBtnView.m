//
//  DDHomeworkBtnView.m
//  DDCampus
//
//  Created by wu on 16/8/12.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeworkBtnView.h"

@interface DDHomeworkBtnView ()

{
    NSInteger tag;
}
@end

@implementation DDHomeworkBtnView

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
    _colorLabel.backgroundColor = RGB(101, 200, 126);
    tag = 1001;
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    CGFloat width = SCREEN_WIDTH/3;
    _allButton.frame = CGRectMake(0, 0, width, self.frame.size.height-1);
    _yiButton.frame = CGRectMake(width, 0, width, self.frame.size.height-1);
    _weiButton.frame = CGRectMake(SCREEN_WIDTH-width, 0, width, self.frame.size.height-1);
    _lineLabel.frame = CGRectMake(0, self.frame.size.height-1, SCREEN_WIDTH, 1);
    if (tag==1001) {
        _colorLabel.frame = CGRectMake(_allButton.frame.origin.x, self.frame.size.height-2, width, 3);
    }else if (tag == 1002)
    {
        _colorLabel.frame = CGRectMake(_yiButton.frame.origin.x, self.frame.size.height-2, width, 3);
    }else{
        _colorLabel.frame = CGRectMake(_weiButton.frame.origin.x, self.frame.size.height-2, width, 3);
    }
}
- (IBAction)buttonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    CGFloat width = SCREEN_WIDTH/3;
    if (button.tag == 1001 && tag != button.tag) {
        tag = button.tag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_allButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        if (_clickHandler) {
            _clickHandler(tag);
        }
    }
    else if (button.tag == 1002 && tag != button.tag){
        tag = button.tag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_yiButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        if (_clickHandler) {
            _clickHandler(tag);
        }
    }
    else
    {
        tag = button.tag;
        [UIView animateWithDuration:0.25 animations:^{
           _colorLabel.frame = CGRectMake(_weiButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        if (_clickHandler) {
            _clickHandler(tag);
        }
    }
}

- (void)setColorFrame:(NSInteger)btnTag
{
    CGFloat width = SCREEN_WIDTH/3;
    if (btnTag == 1001 && tag != btnTag) {
        tag = btnTag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_allButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        
    }
    else if (btnTag == 1002 && tag != btnTag){
        tag = btnTag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_yiButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        
    }
    else if(btnTag == 1003 && tag != btnTag)
    {
        tag = btnTag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_weiButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
    }
}

@end
