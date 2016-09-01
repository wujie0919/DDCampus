//
//  DDTeacherScoreTableViewCell.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTeacherScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *nameView;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;
@property (nonatomic, copy) NSDictionary *dic;
- (void)setData:(NSDictionary *)data;
@end
