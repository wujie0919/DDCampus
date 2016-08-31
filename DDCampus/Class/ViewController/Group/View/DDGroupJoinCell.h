//
//  DDGroupJoinCell.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDJoinModel.h"

typedef void(^OptionClickHandelr)(NSInteger flg);

@interface DDGroupJoinCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *refuseButton;
@property (weak, nonatomic) IBOutlet DDButton *agreeButton;
@property (nonatomic, copy) OptionClickHandelr handler;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet DDImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

- (void)setValue:(DDJoinModel *)joinModel;
@end
