//
//  AppDelegate.h
//  DDCampus
//
//  Created by Aaron on 16/8/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDUserModel.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDUserModel *userModel;
@property (strong, nonatomic) NSMutableArray *classArray;
- (void)showControllerWithLoginSuccess;
@end

