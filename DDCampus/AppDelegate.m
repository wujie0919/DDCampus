//
//  AppDelegate.m
//  DDCampus
//
//  Created by Aaron on 16/8/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "AppDelegate.h"
#import "DDTabBarController.h"
#import "DDLoginController.h"
#import "DDNavigationController.h"
#import "DDRoutineSelectStudentModel.h"

AppDelegate* appDelegate = nil;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    appDelegate = self;
    if ([[USER_DEFAULT valueForKey:USER_LOGIN]isEqualToString:@"isLogin"]) {
        _userModel = [NSTools getUserInfo];
        [self showControllerWithLoginSuccess];
    }
    else{
        DDLoginController *loginControoler = [[DDLoginController alloc]initWithNibName:@"DDLoginController" bundle:nil];
        DDNavigationController *navController = [[DDNavigationController alloc]initWithRootViewController:loginControoler];
        self.window.rootViewController = navController;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LogOut:) name:TOKENOVERDUE object:nil];
    return YES;
}

- (void)LogOut:(NSNotification *)notic
{
    [MBProgressHUD showError:@"请重新登录"];
    [self showLogin];
}

- (void)showLogin{
    [NSTools setObject:@"" forKey:USER_LOGIN];
    [NSTools setObject:nil forKey:UserInfo];
    DDLoginController *loginControoler = [[DDLoginController alloc]initWithNibName:@"DDLoginController" bundle:nil];
    DDNavigationController *navController = [[DDNavigationController alloc]initWithRootViewController:loginControoler];
    self.window.rootViewController = navController;
}

- (void)showControllerWithLoginSuccess
{
    DDTabBarController *tabBarController = [[DDTabBarController alloc]init];
    self.window.rootViewController = tabBarController;
    @WeakObj(self);
    NSString *class_id = [USER_DEFAULT objectForKey:classid];
    [self Network_Post:@"getteacherclass"
                   tag:Getteacherclass_Tag
                 param:nil success:^(id result) {
                     if ([result[@"code"]integerValue]==200) {
                         NSMutableArray *array = [NSMutableArray new];
                         if ([result[DataKey] isKindOfClass:[NSArray class]]) {
                             for (NSDictionary *dic in result[DataKey]) {
                                 DDRoutineSelectStudentModel *sModel = [[DDRoutineSelectStudentModel alloc]init];
                                 sModel.class_id = dic[@"id"];
                                 sModel.name = dic[@"name"];
                                 sModel.selected = [sModel.class_id isEqualToString:class_id]?YES:NO;
                                 [array addObject:sModel];
                             }
                         }
                         selfWeak.classArray = array;
                         NSNotification * notice = [NSNotification notificationWithName:GetClassNameSuccess object:nil userInfo:@{@"value":array}];
                         //发送消息
                         [[NSNotificationCenter defaultCenter]postNotification:notice];
                     }
                     
                 } failure:^(NSError *error) {
                     
                 }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
