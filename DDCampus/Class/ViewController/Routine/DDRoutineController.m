//
//  DDRoutineController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineController.h"
#import "DDRoutineBtnView.h"
#import "DDRoutineListController.h"
#import "DDRoutinDayController.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDRoutineController ()
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) DDRoutineBtnView *routineView;
@property (nonatomic, strong) DDRoutineListController *rVC;
@property (nonatomic, assign) NSInteger type ;
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation DDRoutineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([_selectIndex isValidString]) {
        _index = [_selectIndex integerValue];
    }
    else
    {
        _index = 0;
    }
    
    [self showTitle];
    _routineView = [[[NSBundle mainBundle] loadNibNamed:@"DDRoutineBtnView" owner:nil options:nil] lastObject];
    
    @WeakObj(self);
    _routineView.clickHandler = ^(NSInteger tag){
        selfWeak.index = tag -1001;
        [selfWeak.scrollview setContentOffset:CGPointMake(selfWeak.index*SCREEN_WIDTH, 0) animated:YES];
        selfWeak.rVC.view.frame = CGRectMake(selfWeak.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, selfWeak.scrollview.frame.size.height);
        [selfWeak.rVC setIndex:selfWeak.index];
        [selfWeak showTitle];
    };
    [self.view addSubview:_routineView];
    [_routineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
        make.left.equalTo(selfWeak.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    _type = [appDelegate.userModel.type integerValue];
    _rVC = [[DDRoutineListController alloc]initWithNibName:@"DDHomeWorkInfoController" bundle:nil];
    _rVC.routineBlock = ^(NSDictionary *dic){
        if (selfWeak.type==3) {
            DDRoutinDayController *dayVC = [[DDRoutinDayController alloc]initWithNibName:@"DDRoutinDayController" bundle:nil];
            dayVC.dutydayid = dic[@"id"];
            dayVC.handler = ^(){
                [selfWeak.rVC loadData];
            };
            [selfWeak.navigationController pushViewController:dayVC animated:YES];
        }
    };
    _scrollview.frame = CGRectMake(0, _routineView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT- self.routineView.frame.size.height);
    _scrollview.bounces = NO;
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT-self.routineView.frame.size.height);
    _rVC.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH,_scrollview.frame.size.height);
    [_scrollview addSubview:_rVC.view];
    [_rVC setIndex:_index];
    [self setRightButtonName:appDelegate.classArray];
    [self.scrollview setContentOffset:CGPointMake(self.index*SCREEN_WIDTH, 0) animated:YES];
    self.rVC.view.frame = CGRectMake(self.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollview.frame.size.height);
    [_routineView setColorFrame:_index+1001];
}

- (void)setSelectIndex:(NSString *)selectIndex
{
    _selectIndex = selectIndex;
    if (_routineView) {
        _index = [selectIndex integerValue];
        [_rVC setIndex:_index];
        [self.scrollview setContentOffset:CGPointMake(self.index*SCREEN_WIDTH, 0) animated:YES];
        self.rVC.view.frame = CGRectMake(self.index*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollview.frame.size.height);
        [_routineView setColorFrame:_index+1001];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(recieveNotice:) name:GetClassNameSuccess object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetClassNameSuccess object:nil];
}

- (void)recieveNotice:(NSNotification *)notice
{
    NSDictionary *noticeDic = notice.userInfo;
    [self setRightButtonName:noticeDic[@"value"]];
}

- (void)setRightButtonName:(NSMutableArray *)array
{
    if (_type ==3)
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
        DDRoutineSelectStudentModel *model = nameList[0];
        [selfWeak.rightButton setTitle:model.name forState:UIControlStateNormal];
        [NSTools setObject:model.class_id forKey:classid];
        [NSTools setObject:model.name forKey:classname];
        [selfWeak.rVC loadData];
    } singleFlg:NO];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    _index = fabs(sView.contentOffset.x) / sView.frame.size.width;
    if (_routineView) {
        [_routineView setColorFrame:_index+1001];
    }
    _rVC.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollview.frame.size.height);
    [_rVC setIndex:_index];
    [self showTitle];
}



- (void)showTitle{
    if (_index ==0) {
        self.navigationItem.title = @"事务";
        [self setRightButtonName:appDelegate.classArray];
    }else{
        self.navigationItem.title = @"值周成绩";
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

- (void)showWeek
{
    
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
