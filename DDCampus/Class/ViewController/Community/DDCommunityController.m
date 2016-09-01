//
//  DDCommunityController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityController.h"
#import "DDCommunityView.h"
#import "DDCommunityListController.h"
#import "IQKeyboardManager.h"
#import "DDSendCommunityController.h"
#import "DDGroupInfoController.h"
#import "DDFindGroupController.h"
#import "DDCommunityHeaderView.h"
#import "DDCommounityModel.h"

@interface DDCommunityController ()
@property (nonatomic, strong) DDCommunityView *communityView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) DDCommunityListController *listController;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIButton *sendCommunityButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation DDCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"社区";
    DDCommunityHeaderView *headerView = [DDCommunityHeaderView headerView:CGRectMake(0, 0, SCREEN_WIDTH, 45) selectBlock:^(NSInteger tag, DDCommounityModel *model) {
        
    }];
    NSMutableArray *array=[NSMutableArray new];
    for (int i=0; i<7; i++) {
        DDCommounityModel *model = [[DDCommounityModel alloc]init];
        model.name = @"公共社区";
        [array addObject:model];
    }
    headerView.dataSource = array;
    [self.view addSubview:headerView];
//    _index = 0;
//   
//    [self getData];
//    _communityView = [[DDCommunityView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
//    [self.view  addSubview:_communityView];
//    @WeakObj(self);
//    [_communityView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(selfWeak.view).offset(0);
//        make.right.equalTo(selfWeak.view).offset(0);
//        make.left.equalTo(selfWeak.view).offset(0);
//        make.height.mas_equalTo(45);
//    }];
//
//    _listController = [[DDCommunityListController alloc]initWithNibName:@"DDCommunityListController" bundle:nil];
//    _scrollview.frame = CGRectMake(0, self.communityView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT- self.communityView.frame.size.height);
//    _scrollview.bounces = NO;
//    _scrollview.pagingEnabled = YES;
//    
//    _listController.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH,_scrollview.frame.size.height);
//    [_scrollview addSubview:_listController.view];
//    [_listController setIndex:0];
//    _communityView.handler = ^(NSInteger tag){
//        if (selfWeak.listController) {
//            [selfWeak showTitle];
//            selfWeak.listController.groupDic = selfWeak.communityView.dataArray[tag];
//            [selfWeak.listController setIndex:tag];
//        }
//    };
//    
//    _sendCommunityButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_sendCommunityButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
//    [_sendCommunityButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateHighlighted];
//    [_sendCommunityButton addTarget:self action:@selector(enditCommunity:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_sendCommunityButton];
//    [_sendCommunityButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(selfWeak.view).with.offset(-40);
//        make.right.equalTo(selfWeak.view).with.offset(-20);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
//    _listController.handler = ^(NSMutableArray *groupArray){
//        
//    };
}



- (void)enditCommunity:(UIButton *)button
{
    DDSendCommunityController *sendVC = [[DDSendCommunityController alloc]initWithNibName:@"DDSendCommunityController" bundle:nil];
    [self.navigationController pushViewController:sendVC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    _index = fabs(sView.contentOffset.x) / sView.frame.size.width;
    if (_communityView) {
        [_communityView setColorFrame:_index];
    }
    _listController.view.frame = CGRectMake(_index*SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollview.frame.size.height);
    _listController.groupDic = _communityView.dataArray[_index];
    [_listController setIndex:_index];
    [self showTitle];
}

- (void)showTitle{
    NSDictionary *dic = _communityView.dataArray[_index];
    if ([dic[@"type"]integerValue]!=3) {
        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.backgroundColor = RGB(48, 185, 113);
        _rightButton.frame = CGRectMake(0, 5, 100, 30);
        _rightButton.layer.cornerRadius= 5;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 1;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        [_rightButton addTarget:self action:@selector(findGroup) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitle:@"发现社区" forState:UIControlStateNormal];
       
    }else{
        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.backgroundColor = RGB(48, 185, 113);
        _rightButton.frame = CGRectMake(0, 5, 100, 30);
        _rightButton.layer.cornerRadius= 5;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 1;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        [_rightButton addTarget:self action:@selector(showGroupInfo) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitle:@"群组资料" forState:UIControlStateNormal];
    }
}
- (void)findGroup
{
    DDFindGroupController *findVC = [[DDFindGroupController alloc]initWithNibName:@"DDFindGroupController" bundle:nil];
    @WeakObj(self);
    findVC.joinBlock = ^()
    {
        [selfWeak getData];
    };
    [self.navigationController pushViewController:findVC animated:YES];
}

- (void)showGroupInfo
{
    DDGroupInfoController *infoVc = [[DDGroupInfoController alloc]initWithNibName:@"DDGroupInfoController" bundle:nil];
    if (_communityView.dataArray.count >= _index) {
        infoVc.groupDic = _communityView.dataArray[_index];
        @WeakObj(self);
        infoVc.exitBlock = ^(){
            [selfWeak getData];
        };
        [self.navigationController pushViewController:infoVc animated:YES];
    }
}

- (void)getData
{
    @WeakObj(self);
    [self Network_Post:@"getforumpost"
                   tag:Getforumpost_Tag
                 param:@{@"pagesize":@(1),
                         @"page":@(1),
                         @"type":@"1",
                         @"groupid":@""} success:^(id result) {
                    
                             if ([result[@"code"]integerValue]==200) {
                                 NSMutableArray *gArray = [NSMutableArray arrayWithCapacity:0];
                                 [selfWeak showTitle];
                                 [gArray addObjectsFromArray:result[DataKey][@"group"]];
                                 selfWeak.communityView.dataArray = gArray;
                                 selfWeak.scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*selfWeak.communityView.dataArray.count,SCREEN_HEIGHT-selfWeak.communityView.frame.size.height);
                             }
                             
                         } failure:^(NSError *error) {
                             
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
