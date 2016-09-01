//
//  DDCreateScoreController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCreateScoreController.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDCreateScoreController ()
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@end

@implementation DDCreateScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"成绩单";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showClass)];
    [_classView addGestureRecognizer:tap];
}

- (void)showClass
{
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:appDelegate.classArray handler:^(NSMutableArray *nameList) {
        DDRoutineSelectStudentModel *model = nameList[0];
        selfWeak.classNameLabel.text = model.name;
    } singleFlg:NO];
    
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
