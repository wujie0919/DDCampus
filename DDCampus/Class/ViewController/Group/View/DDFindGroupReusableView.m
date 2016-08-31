//
//  DDFindGroupReusableView.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDFindGroupReusableView.h"

@implementation DDFindGroupReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _addButton.backgroundColor = RGB(101, 200, 126);
    _addButton.layer.masksToBounds = YES;
    _addButton.layer.cornerRadius = 5;
}

@end
