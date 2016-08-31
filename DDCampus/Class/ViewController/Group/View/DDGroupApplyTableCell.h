//
//  DDGroupApplyTableCell.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDGroupSetManagerModel;

typedef void(^CancenClickBlock)();

@interface DDGroupApplyTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet DDImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *optButton;
@property (nonatomic, copy) CancenClickBlock cancelBlock;
- (void)setData:(DDGroupSetManagerModel *)model;
@end
