//
//  DDHomeworkCell.h
//  DDCampus
//
//  Created by wu on 16/8/13.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDHomeworkModel;

@interface DDHomeworkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UILabel *teacher_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *week_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (nonatomic, assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

- (void)setData:(DDHomeworkModel *)homeworkModel row:(NSInteger)row;
@end
