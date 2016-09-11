//
//  DDNewHomeworkController.m
//  DDCampus
//
//  Created by wu on 16/9/11.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNewHomeworkController.h"
#import "DDHomeWorkInfoController.h"

@interface DDNewHomeworkController ()
@property (nonatomic, strong) NSArray *musicCategories;
@end

@implementation DDNewHomeworkController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"全部",@"已提交",@"未提交"];
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
    self.title = @"作业";
    NSInteger type = [appDelegate.userModel.type integerValue];
    if (type ==2)
    {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:@"全部提交" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        rightButton.backgroundColor = RGB(48, 185, 113);
        rightButton.frame = CGRectMake(0, 5, 80, 30);
        rightButton.layer.cornerRadius= 5;
        rightButton.layer.masksToBounds = YES;
        rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        rightButton.layer.borderWidth = 1;
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(senderHomeWork:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    DDHomeWorkInfoController *vc = [[DDHomeWorkInfoController alloc] initWithNibName:@"DDHomeWorkInfoController" bundle:nil];
    [vc setIndex:index];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
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
