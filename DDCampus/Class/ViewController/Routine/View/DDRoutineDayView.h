//
//  DDRoutineDayView.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRoutineDayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentLabel;
@property (nonatomic, assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabe;
- (void)setDayValue:(NSDictionary *)dic;
@end
