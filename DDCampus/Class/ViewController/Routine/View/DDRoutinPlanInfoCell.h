//
//  DDRoutinPlanInfoCell.h
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRoutinPlanInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *zhizhouLable;
@property (weak, nonatomic) IBOutlet UILabel *fuzelabel;
@property (nonatomic,assign) CGFloat height;
- (void)setCellData:(NSDictionary *)dic;
@end
