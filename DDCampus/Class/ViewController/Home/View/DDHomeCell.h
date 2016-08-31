//
//  DDHomeCell.h
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHomeCellView.h"


@interface DDHomeCell : UITableViewCell

@property (nonatomic, strong) DDHomeCellView *homeView;
- (void)setHomeViewFrame:(CGRect)rect;
@end
