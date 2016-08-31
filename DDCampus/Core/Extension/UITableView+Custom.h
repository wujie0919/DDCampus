//
//  UITableView+Custom.h
//  YCB_iOS_OAClient
//
//  Created by Pan Lee on 16/5/13.
//  Copyright © 2016年 ycb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Custom)

- (void)customeReloadRowsAtIndexPaths:(NSArray <NSIndexPath *>*)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end
