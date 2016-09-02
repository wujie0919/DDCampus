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
#import "DDScoreInfoListController.h"
#import "DDCurveViewController.h"
#import "DDCreateScoreController.h"

@interface DDScoreInfoController ()<UIScrollViewDelegate>
@property (nonatomic, strong) DDScoreInfoView *scoreView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) DDScoreInfoListController *scoreVC;
@end

@implementation DDScoreInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _index = 0;
    _scoreView = [[DDScoreInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    @WeakObj(self);
    _scoreView.handler = ^(NSInteger tag){
        selfWeak.index = tag;
        [selfWeak.scrollview setContentOffset:CGPointMake(selfWeak.index*SCREEN_WIDTH, 0) animated:YES];
        if (selfWeak.model) {
            selfWeak.scoreVC.classId = selfWeak.model.class_id;
        }
        [selfWeak.scoreVC setIndex:selfWeak.index];
        selfWeak.scoreVC.view.frame = CGRectMake(selfWeak.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, selfWeak.scrollview.frame.size.height);
    };
    self.title = @"成绩";
    _scoreView.titleArray = @[@"成绩单",@"成绩趋势"];
    [self.view addSubview:_scoreView];
    
    _scrollview.frame = CGRectMake(0, _scoreView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT- _scrollview.frame.size.height);
    _scrollview.bounces = NO;
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*_scoreView.titleArray.count,SCREEN_HEIGHT-_scrollview.frame.size.height);
    _scoreVC = [[DDScoreInfoListController alloc]initWithNibName:@"DDScoreInfoListController" bundle:nil];
    [_scrollview addSubview:_scoreVC.view];
    
    _scoreVC.block = ^(NSDictionary *dict){
        DDCurveViewController *curveVC = [[DDCurveViewController alloc]initWithNibName:@"DDCurveViewController" bundle:nil];
        curveVC.dic = dict;
        [selfWeak.navigationController pushViewController:curveVC animated:YES];
    };
    _scoreVC.view.frame = CGRectMake(self.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollview.frame.size.height);
    if (_model) {
        _scoreVC.classId = _model.class_id;
    }
//    [_scoreVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak.scrollview).offset(0);
//        make.right.equalTo(selfWeak.scrollview).offset(0);
//        make.left.equalTo(selfWeak.scrollview).offset(0);
//        make.bottom.equalTo(selfWeak.scrollview).offset(0);
//    }];
    [_scoreVC setIndex:_index];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    _index = fabs(sView.contentOffset.x) / sView.frame.size.width;
    if (_scoreView) {
        [_scoreView setColorFrame:_index];
    }
    [self.scrollview setContentOffset:CGPointMake(self.index*SCREEN_WIDTH, 0) animated:YES];
    if (_model) {
        _scoreVC.classId = _model.class_id;
    }
    [_scoreVC setIndex:_index];
    _scoreVC.view.frame = CGRectMake(self.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollview.frame.size.height);
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
