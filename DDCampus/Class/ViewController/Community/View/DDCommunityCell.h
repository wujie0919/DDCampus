//
//  DDCommunityCell.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCommunityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (nonatomic, assign) CGFloat height;
- (void)setValue:(NSString *)text count:(NSInteger)count;
@end
