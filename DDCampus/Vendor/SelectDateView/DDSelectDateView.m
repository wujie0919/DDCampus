//
//  DDSelectDateView.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSelectDateView.h"

@interface DDSelectDateView ()
@property (nonatomic, copy) NSString *date;
@end

@implementation DDSelectDateView

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
    _datePicker.minimumDate = [NSDate date];
}

- (IBAction)dateChange:(id)sender{
    
    UIDatePicker *dPicker = (UIDatePicker *)sender;
    self.date = [dPicker.date stringWithFormate:@"yyyy-MM-dd"];
}
- (IBAction)selectDate:(id)sender {
    if (_handler) {
        _handler(self.date?self.date:[[NSDate date]stringWithFormate:@"yyyy-MM-dd"]);
    }
}

@end
