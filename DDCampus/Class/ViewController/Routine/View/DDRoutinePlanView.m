//
//  DDRoutinePlanView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinePlanView.h"

@implementation DDRoutinePlanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setData:(NSDictionary *)dic
{
    _weeknameLabel.text = dic[@"weekname"];
    _dateLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate getDateValue:dic[@"startday"] format:@"MM月-dd"],[NSDate getDateValue:dic[@"endday"] format:@"MM月-dd"]];
}
@end
