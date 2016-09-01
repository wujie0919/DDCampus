//
//  DDCommunityHeaderCell.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCommounityModel.h"

@interface DDCommunityHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
- (void)setData:(DDCommounityModel *)model;
@end
