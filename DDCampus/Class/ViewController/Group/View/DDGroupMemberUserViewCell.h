//
//  DDGroupMemberUserViewCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGroupMemberUserViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DDImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (void)setCellData:(NSDictionary *)dic;
@end
