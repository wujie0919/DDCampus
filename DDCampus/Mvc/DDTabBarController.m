//
//  DDTabBarController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTabBarController.h"
#import "DDCommunityController.h"
#import "DDHomeWorkController.h"
#import "DDHomeController.h"
#import "DDRoutineController.h"
#import "DDMineController.h"
#import "DDNavigationController.h"
#import "DDNewCommunityViewController.h"
#import "DDTeacherHomeworkController.h"
#import "DDNewRoutineController.h"
#import "DDNewHomeworkController.h"

@interface DDTabBarController ()<UITabBarControllerDelegate>

@end

@implementation DDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //首页
    DDHomeController *homeController = [[DDHomeController alloc]initWithNibName:@"DDHomeController" bundle:nil];
    DDNavigationController *homeNav = [[DDNavigationController alloc] initWithRootViewController:homeController];
    homeNav.tabBarItem.title = @"首页";
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"icon_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //作业
    DDNewHomeworkController *workController = [[DDNewHomeworkController alloc]init];
    DDNavigationController *workNav = [[DDNavigationController alloc] initWithRootViewController:workController];
    workNav.tabBarItem.title = @"作业";
    workNav.tabBarItem.image = [[UIImage imageNamed:@"icon_xue_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    workNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_xue_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //老师作业
    DDTeacherHomeworkController *teacherController = [[DDTeacherHomeworkController alloc]initWithNibName:@"DDTeacherHomeworkController" bundle:nil];
    DDNavigationController *teacherNav = [[DDNavigationController alloc] initWithRootViewController:teacherController];
    teacherNav.tabBarItem.title = @"作业";
    teacherNav.tabBarItem.image = [[UIImage imageNamed:@"icon_xue_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    teacherNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_xue_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //事务
    DDNewRoutineController *routineController = [[DDNewRoutineController alloc]init];
    DDNavigationController *routineNav = [[DDNavigationController alloc] initWithRootViewController:routineController];
    routineNav.tabBarItem.title = @"事务";
    routineNav.tabBarItem.image = [[UIImage imageNamed:@"icon_shi_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    routineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_shi_selectd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //社区
//    DDCommunityController *communityController = [[DDCommunityController alloc]initWithNibName:@"DDCommunityController" bundle:nil];
    
    DDNewCommunityViewController *communityController = [[DDNewCommunityViewController alloc]initWithNibName:@"DDNewCommunityViewController" bundle:nil];
    DDNavigationController *communityNav = [[DDNavigationController alloc] initWithRootViewController:communityController];
    communityNav.tabBarItem.title = @"社区";
    communityNav.tabBarItem.image = [[UIImage imageNamed:@"icon_she_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communityNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_she_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //我的
    DDMineController *mineController = [[DDMineController alloc]initWithNibName:@"DDMineController" bundle:nil];
    DDNavigationController *mineNav = [[DDNavigationController alloc] initWithRootViewController:mineController];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"icon_wo_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_wo_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSInteger type = [appDelegate.userModel.type integerValue];
    if (type == 3) {
        self.viewControllers = @[homeNav,teacherNav,routineNav,communityNav,mineNav];
    }
    else
    {
        self.viewControllers = @[homeNav,workNav,routineNav,communityNav,mineNav];
    }
    
//    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
