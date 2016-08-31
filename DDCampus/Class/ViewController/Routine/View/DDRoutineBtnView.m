//
//  DDRoutineBtnView.m
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineBtnView.h"

@interface DDRoutineBtnView ()
{
    NSInteger tag;
}

@end

@implementation DDRoutineBtnView

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
    CGFloat width = SCREEN_WIDTH/2;
    _dayButton.frame = CGRectMake(0, 0, width, self.frame.size.height-1);
    _weekButton.frame = CGRectMake(width, 0, width, self.frame.size.height-1);
    _lineLabel.frame = CGRectMake(0, self.frame.size.height-1, SCREEN_WIDTH, 1);
    if (tag==1001) {
        _colorLabel.frame = CGRectMake(_dayButton.frame.origin.x, self.frame.size.height-2, width, 3);
    }else if (tag == 1002)
    {
        _colorLabel.frame = CGRectMake(_weekButton.frame.origin.x, self.frame.size.height-2, width, 3);
    }
}
- (IBAction)buttonClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    CGFloat width = SCREEN_WIDTH/2;
    if (button.tag == 1001 && tag != button.tag) {
        tag = button.tag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_dayButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        if (_clickHandler) {
            _clickHandler(tag);
        }
    }
    else if (button.tag == 1002 && tag != button.tag){
        tag = button.tag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_weekButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        if (_clickHandler) {
            _clickHandler(tag);
        }
    }
}

- (void)setColorFrame:(NSInteger)btnTag
{
    CGFloat width = SCREEN_WIDTH/2;
    if (btnTag == 1001 && tag != btnTag) {
        tag = btnTag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_dayButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        
    }
    else if (btnTag == 1002 && tag != btnTag){
        tag = btnTag;
        [UIView animateWithDuration:0.25 animations:^{
            _colorLabel.frame = CGRectMake(_weekButton.frame.origin.x, self.frame.size.height-2, width, 3);
        }];
        
    }
}

@end
