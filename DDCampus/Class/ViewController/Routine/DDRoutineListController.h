//
//  DDRoutineListController.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseViewController.h"
@class DDClassweekpointModel;
typedef void(^RoutineClickBlock)(NSDictionary *data);
typedef void(^GetIsWeekDayBlock)(BOOL status);
typedef void(^GetWeekBlock)(DDClassweekpointModel *model);

@interface DDRoutineListController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, assign)  NSInteger index;
@property (nonatomic, copy) RoutineClickBlock routineBlock;
@property (nonatomic, copy) GetIsWeekDayBlock weekBlock;
@property (nonatomic, copy) GetWeekBlock gBlock;
- (void)loadData;
@end
