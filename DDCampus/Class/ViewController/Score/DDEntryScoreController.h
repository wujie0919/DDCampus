//
//  DDEntryScoreController.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDEntryScoreController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy)  NSString *headerTitle;
@property (nonatomic, copy) NSDictionary *dataDic;
@end
