//
//  DDScoreInfoController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreInfoController.h"
#import "DDScoreInfoView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDScoreInfoController ()
@property (nonatomic, strong) DDScoreInfoView *scoreView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@end

@implementation DDScoreInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _scoreView = [[DDScoreInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    _scoreView.handler = ^(NSInteger tag){
        
    };
    _scoreView.titleArray = @[@"成绩单",@"成绩趋势"];
    [self.view addSubview:_scoreView];
    
    _scrollview.frame = CGRectMake(0, _scoreView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT- _scoreView.frame.size.height);
    _scrollview.bounces = NO;
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*_scoreView.titleArray.count,SCREEN_HEIGHT-_scoreView.frame.size.height);
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
