//
//  DDCommentCell.h
//  DDCampus
//
//  Created by wu on 16/8/24.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

@interface DDCommentCell : UITableViewCell
@property (nonatomic, strong) YYLabel *label;

- (void)setLabelValue:(NSString *)nickName content:(NSString *)text;
@end
