    //
//  DDNewScoreInfoController.m
//  DDCampus
//
//  Created by wu on 16/9/11.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNewScoreInfoController.h"
#import "DDScoreInfoListController.h"
#import "DDCreateScoreController.h"

static CGFloat const kWMHeaderViewHeight = 200;
static CGFloat const kNavigationBarHeight = 64;

@interface DDNewScoreInfoController ()
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, assign) CGFloat viewTop;
@end

@implementation DDNewScoreInfoController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"成绩单",@"成绩趋势"];
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
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackBarButtonItem];
    self.title = @"成绩";
    NSInteger type = [appDelegate.userModel.type integerValue];
    if (type==3) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:@"创建成绩单" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        rightButton.backgroundColor = RGB(48, 185, 113);
        rightButton.frame = CGRectMake(0, 5, 80, 30);
        rightButton.layer.cornerRadius= 5;
        rightButton.layer.masksToBounds = YES;
        rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        rightButton.layer.borderWidth = 1;
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(createScore) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
}

- (void)createScore
{
    DDCreateScoreController *createVC = [[DDCreateScoreController alloc]initWithNibName:@"DDCreateScoreController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    DDScoreInfoListController *vc = [[DDScoreInfoListController alloc] initWithNibName:@"DDScoreInfoListController" bundle:nil];
    if (self.model) {
        vc.classId = self.model.class_id;
    }
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
