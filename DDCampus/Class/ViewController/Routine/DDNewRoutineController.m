//
//  DDNewRoutineController.m
//  DDCampus
//
//  Created by wu on 16/9/11.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNewRoutineController.h"
#import "DDRoutineListController.h"
#import "DDRoutineSelectStudentModel.h"
#import "DDSelectClassActionView.h"
#import "DDRoutinePlanController.h"

@interface DDNewRoutineController ()
@property (nonatomic, copy) NSArray *musicCategories;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) BOOL isdutyweekuser;
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) DDRoutineListController *vc;
@end

@implementation DDNewRoutineController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"值日",@"值周"];
    }
    return _musicCategories;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.menuHeight = 50;
        self.titleColorSelected = RGB(101, 200, 126);
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitle:0];
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    _vc = [[DDRoutineListController alloc] initWithNibName:@"DDRoutineListController" bundle:nil];
    [_vc setIndex:index];
    return _vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    NSInteger index = [info[@"index"]integerValue];
    if (index == 1) {
        @WeakObj(self);
        _vc.weekBlock = ^(BOOL status)
        {
            if (status != selfWeak.isdutyweekuser) {
                selfWeak.isdutyweekuser = status;
                [selfWeak showTitle:index];
            }
        };
        [selfWeak showTitle:index];
    }
    else
    {
        [self showTitle:index];
    }
}

- (void)showTitle:(NSInteger)index{
    if (index ==0) {
        self.navigationItem.title = @"事务";
        _rightButton.hidden = NO;
        [self setRightButtonName:appDelegate.classArray];
    }else{
        self.navigationItem.title = @"值周成绩";
        _rightButton.hidden = !self.isdutyweekuser;
        if (self.isdutyweekuser) {
            _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightButton setTitle:@"安排值周" forState:UIControlStateNormal];
            _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
            _rightButton.backgroundColor = RGB(48, 185, 113);
            _rightButton.frame = CGRectMake(0, 5, 100, 30);
            _rightButton.layer.cornerRadius= 5;
            _rightButton.layer.masksToBounds = YES;
            _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
            _rightButton.layer.borderWidth = 1;
            [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_rightButton addTarget:self action:@selector(showWeek) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        }
    }
}

- (void)setRightButtonName:(NSMutableArray *)array
{
    NSInteger type = [appDelegate.userModel.type integerValue];
    if (type ==3)
    {
        NSString *class_id = [USER_DEFAULT objectForKey:classid];
        NSString *buttonName = [USER_DEFAULT objectForKey:classname];
        for (DDRoutineSelectStudentModel *model in array) {
            if ([model.class_id isEqualToString:class_id] && ![buttonName isEqualToString:model.name]) {
                buttonName = model.name;
                [NSTools setObject:buttonName forKey:classname];
                break;
            }
        }
        if ([buttonName isValidString]) {
            _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightButton setTitle:buttonName forState:UIControlStateNormal];
            _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
            _rightButton.backgroundColor = RGB(48, 185, 113);
            _rightButton.frame = CGRectMake(0, 5, 100, 30);
            _rightButton.layer.cornerRadius= 5;
            _rightButton.layer.masksToBounds = YES;
            _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
            _rightButton.layer.borderWidth = 1;
            [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_rightButton addTarget:self action:@selector(showClass) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        }
    }
}

- (void)showClass
{
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:appDelegate.classArray handler:^(NSMutableArray *nameList) {
        if (nameList.count>0) {
            DDRoutineSelectStudentModel *model = nameList[0];
            [selfWeak.rightButton setTitle:model.name forState:UIControlStateNormal];
            [NSTools setObject:model.class_id forKey:classid];
            [NSTools setObject:model.name forKey:classname];
        }
        [selfWeak.vc loadData];
    } singleFlg:NO];
    
}

- (void)showWeek
{
    DDRoutinePlanController *planVC=[[DDRoutinePlanController alloc]initWithNibName:@"DDRoutinePlanController" bundle:nil];
    [self.navigationController pushViewController:planVC animated:YES];
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
