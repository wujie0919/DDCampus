//
//  DDHomeWorkInfoController.h
//  DDCampus
//
//  Created by wu on 16/8/25.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseViewController.h"
#import "DDHomeworkModel.h"


typedef void(^TableSelectBlock)(DDHomeworkModel *model);

@interface DDHomeWorkInfoController : DDBaseViewController
@property (nonatomic, copy) TableSelectBlock tbsBlock;
@property (nonatomic) NSInteger index;
@end
