//
//  DDCommunityListController.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseViewController.h"

typedef void(^GetJoinGroupListHandler)(NSMutableArray *groupArray);

@interface DDCommunityListController : DDBaseViewController
@property (nonatomic, copy) NSDictionary *groupDic;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) GetJoinGroupListHandler handler;
- (void)loadData;
@end
