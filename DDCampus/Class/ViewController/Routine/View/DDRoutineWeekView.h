//
//  DDRoutineWeekView.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowAllButtonHandler)();


@class DDClassweekpointModel;

@interface DDRoutineWeekView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIFont *font;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic, copy) ShowAllButtonHandler handler;

- (void)setWeekData:(DDClassweekpointModel *)model;
@end
