//
//  DDHomeWorkDetailsCell.h
//  DDCampus
//
//  Created by wu on 16/8/17.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDHomeworkDetailsModel;

@interface DDHomeWorkDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *homework_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *homework_teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *homework_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homework_weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *homework_contentLabel;
@property (nonatomic, assign) CGFloat height;
- (void)setDetailsValue:(DDHomeworkDetailsModel *)model;
@end
