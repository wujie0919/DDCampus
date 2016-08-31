//
//  DDGroupInfoController.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

typedef void(^ExitGroupSuccessBlock)();

@interface DDGroupInfoController : DDBaseViewController
@property (nonatomic, copy) ExitGroupSuccessBlock exitBlock;
@property (nonatomic, copy) NSDictionary *groupDic;
@end
