//
//  DDSelectDateView.h
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDataHandler)(NSString *date);
@interface DDSelectDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, copy) SelectDataHandler handler;
@end
