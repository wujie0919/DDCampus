//
//  DDHomeWorkController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeWorkController.h"
#import "DDHomeworkBtnView.h"
#import "DDHomeWorkInfoController.h"
#import "DDHomeWorkDetailsController.h"

@interface DDHomeWorkController ()<UIScrollViewDelegate>

@property (nonatomic, strong) DDHomeworkBtnView *homeworkView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) DDHomeWorkInfoController *hVC;
@property (nonatomic, assign) NSInteger index;
@end

@implementation DDHomeWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    
    
    _index = 0;
    _homeworkView = [[[NSBundle mainBundle] loadNibNamed:@"DDHomeworkBtnView" owner:nil options:nil] lastObject];
    
    @WeakObj(self);
    _homeworkView.clickHandler = ^(NSInteger tag){
        selfWeak.index = tag -1001;
        [selfWeak.scrollview setContentOffset:CGPointMake(selfWeak.index*SCREEN_WIDTH, 0) animated:YES];
        selfWeak.hVC.view.frame = CGRectMake(selfWeak.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, selfWeak.scrollview.frame.size.height);
        [selfWeak.hVC setIndex:selfWeak.index];
    };
    [self.view addSubview:_homeworkView];
    [_homeworkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
        make.left.equalTo(selfWeak.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    _hVC = [[DDHomeWorkInfoController alloc]initWithNibName:@"DDHomeWorkInfoController" bundle:nil];
    _hVC.tbsBlock = ^(DDHomeworkModel *model){
        DDHomeWorkDetailsController *detailsVC = [[DDHomeWorkDetailsController alloc]initWithNibName:@"DDHomeWorkDetailsController" bundle:nil];
        detailsVC.homeworkModel = model;
        [selfWeak.navigationController pushViewController:detailsVC animated:YES];
    };
//    _scrollview.frame = CGRectMake(0, self.homeworkView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT- self.homeworkView.frame.size.height);
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.homeworkView.mas_bottom).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
        make.left.equalTo(selfWeak.view).offset(0);
        make.bottom.equalTo(selfWeak.view).offset(0);
    }];
    _scrollview.bounces = NO;
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*3,SCREEN_HEIGHT-self.homeworkView.frame.size.height);
    _hVC.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH,_scrollview.frame.size.height);
    [_scrollview addSubview:_hVC.view];
    [_hVC setIndex:0];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    _index = fabs(sView.contentOffset.x) / sView.frame.size.width;
    if (_homeworkView) {
        [_homeworkView setColorFrame:_index+1001];
    }
    _hVC.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollview.frame.size.height);
    [_hVC setIndex:_index];
}

int _lastPosition;    //A variable define in headfile

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 100) {
        _lastPosition = currentPostion;
    }
    else if (_lastPosition - currentPostion > 100)
    {
        _lastPosition = currentPostion;
    }
}

- (void)senderHomeWork:(UIButton *)button
{
    @WeakObj(self);
    [self showLoadHUD:@"提交中..."];
    [self Network_Post:@"do_homeworkdone"
                   tag:Do_homeworkdone_Tag param:nil success:^(id result) {
                       [selfWeak hideHUD];
                       if ([result[@"code"]integerValue]==200) {
                           [selfWeak showSuccessHUD:@"提交成功"];
                       }else
                       {
                           [selfWeak showErrorHUD:@"提交失败"];
                       }
                   } failure:^(NSError *error) {
                       [selfWeak hideHUD];
                       [selfWeak showErrorHUD:@"网络异常"];
                   }];
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
