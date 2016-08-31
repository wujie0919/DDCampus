//
//  DDTableView.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTableView.h"

@implementation DDTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tableFooterView = [UIView new];
}

@end
