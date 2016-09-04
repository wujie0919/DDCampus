//
//  DDEntryScoreView.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDEntryScoreView.h"

@implementation DDEntryScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setCellData:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _nameLabel.text = [NSString stringWithFormat:@"%@:",dic[@"name"]];
        _valueText.placeholder = dic[@"score"];
    }
}
- (IBAction)valueChange:(id)sender {
    UITextField *textfiled = (UITextField *)sender;
    if (_scoreBlock) {
        _scoreBlock(textfiled.text,textfiled.tag);
    }
}
@end
