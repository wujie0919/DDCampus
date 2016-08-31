//
//  UITableView+Custom.m
//  YCB_iOS_OAClient
//
//  Created by Pan Lee on 16/5/13.
//  Copyright © 2016年 ycb. All rights reserved.
//

#import "UITableView+Custom.h"

@implementation UITableView (Custom)

- (void)customeReloadRowsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self endUpdates];
}

@end
