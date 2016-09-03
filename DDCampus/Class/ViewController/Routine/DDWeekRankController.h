//
//  DDWeekRankController.h
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDWeekRankController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, copy) NSString *weekplanid;
@end
