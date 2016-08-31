//
//  TransferGroupCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDGroupSetManagerModel;

@interface TransferGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectView;
@property (weak, nonatomic) IBOutlet DDImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (void)setData:(DDGroupSetManagerModel *)model;
@end
