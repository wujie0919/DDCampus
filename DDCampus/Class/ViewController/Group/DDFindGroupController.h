//
//  DDFindGroupController.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

typedef void(^JoinGroupSuccessBlock)();
@interface DDFindGroupController : DDBaseViewController
@property (nonatomic, copy) JoinGroupSuccessBlock joinBlock;
@end
