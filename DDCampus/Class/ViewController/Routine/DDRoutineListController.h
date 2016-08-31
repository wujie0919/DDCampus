//
//  DDRoutineListController.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseViewController.h"

typedef void(^RoutineClickBlock)(NSDictionary *data);

@interface DDRoutineListController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, assign)  NSInteger index;
@property (nonatomic, copy) RoutineClickBlock routineBlock;
- (void)loadData;
@end
