//
//  DDCustomScoreController.h
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDCustomScoreController : DDBaseViewController

// 0 值周安排 1 扣分详情
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSMutableArray *rightDataSource;
@property (nonatomic, strong) NSMutableArray *leftDataSource;

@end
