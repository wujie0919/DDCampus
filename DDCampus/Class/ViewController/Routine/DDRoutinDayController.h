//
//  DDRoutinDayController.h
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

typedef void(^SaveValueSuccessHandler)();

@interface DDRoutinDayController : DDBaseViewController
@property (nonatomic, copy) NSString *dutydayid;
@property (nonatomic, copy) SaveValueSuccessHandler handler;
@end
