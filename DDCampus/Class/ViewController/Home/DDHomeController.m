//
//  DDHomeController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeController.h"
#import "DDHomeImageCell.h"
#import "DDHomeButtonCell.h"
#import "DDHomeCell.h"
#import "DDHomeModel.h"
#import "DDHomeInfoModel.h"
#import "DDPublishHomeworkController.h"
#import "DDPublishNoticeController.h"
#import "LZMomentsCell.h"
#import "LZMoments.h"
#import "LZMomentsViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LZMomentsListViewModel.h"
#import "DDSelectClssController.h"
#import "DDScoreInfoController.h"
#import "ChatKeyBoard.h"
#import "IQKeyboardManager.h"
#import "DDTabBarController.h"
#import "DDNavigationController.h"
#import "DDRoutineController.h"
#import "DDScoreInfoController.h"

static NSString * const imageCell = @"imageCell";
static NSString * const buttonCell = @"buttonCell";
static NSString * const homeCell = @"homeCell";

@interface DDHomeController ()<UITableViewDelegate,UITableViewDataSource,LZMomentsCellDelegate,ChatKeyBoardDelegate>
{
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet DDTableView *homeTable;
@property (nonatomic, strong) DDHomeModel *homeModel;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *buttonImageArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LZMomentsListViewModel *statusListViewModel;
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
// 显示评论弹窗的cell的indexPath
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@end

@implementation DDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";
    page = 1;
    _homeModel = [DDHomeModel new];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [_homeTable registerNib:[UINib nibWithNibName:@"DDHomeImageCell" bundle:nil] forCellReuseIdentifier:imageCell];
    [_homeTable registerNib:[UINib nibWithNibName:@"DDHomeButtonCell" bundle:nil] forCellReuseIdentifier:buttonCell];
//    [_homeTable registerNib:[UINib nibWithNibName:@"DDHomeCell" bundle:nil] forCellReuseIdentifier:homeCell];
    [_homeTable registerClass:[LZMomentsCell class] forCellReuseIdentifier:homeCell];
    @WeakObj(self);
    _homeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [selfWeak loadData];
    }];
    _homeTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [selfWeak loadData];
    }];
    [self loadData];
    [_homeTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSInteger type = [appDelegate.userModel.type integerValue];
    switch (type) {
        case 1:
            _titleArray = @[@"作业",@"成绩",@"值日安排",@"值周安排"];
            _buttonImageArray = @[[UIImage imageNamed:@"zuoye"],[UIImage imageNamed:@"cehngji"],[UIImage imageNamed:@"zhiri"],[UIImage imageNamed:@"zhou"]];
            break;
        case 2:
            _titleArray = @[@"作业",@"成绩",@"值日安排",@"值周安排",@"提交作业"];
            _buttonImageArray = @[[UIImage imageNamed:@"zuoye"],[UIImage imageNamed:@"cehngji"],[UIImage imageNamed:@"zhiri"],[UIImage imageNamed:@"zhou"],[UIImage imageNamed:@"tizuoye"]];
            break;
        case 3:
            _titleArray = @[@"发布作业",@"发布成绩",@"发布通知"];
            _buttonImageArray = @[[UIImage imageNamed:@"zuoye"],[UIImage imageNamed:@"score"],[UIImage imageNamed:@"notice"]];
            break;
        default:
            break;
    }
    _homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:0];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row ==0) {
        height = 160;
    }
    else if (indexPath.row == 1) {
        height = 110;
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:homeCell cacheByIndexPath:indexPath configuration:^(LZMomentsCell *cell) {
            
            // 在这个block中，重新cell配置数据源
            LZMomentsViewModel *viewModel = _dataArray[indexPath.row-2];
            cell.viewModel = viewModel;
        }];
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        DDHomeImageCell *imgCell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        [imgCell.scrollImageView setScrollviewContent:_homeModel.lunbolist];
        cell = imgCell;
        cell.backgroundColor = RGB(221, 226, 222);
    }
    else if (indexPath.row == 1) {
        DDHomeButtonCell *btncell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
        [btncell setTitleDataSource:_titleArray withImageData:_buttonImageArray];
        @WeakObj(self);
        btncell.bcBlock = ^(NSInteger tag){
            [selfWeak showController:tag-1001];
        };
        cell = btncell;
        cell.backgroundColor = RGB(221, 226, 222);
    }
    else
    {
        LZMomentsCell *hCell = [tableView dequeueReusableCellWithIdentifier:homeCell];
        LZMomentsViewModel *viewModel = _dataArray[indexPath.row-2];
        hCell.viewModel = viewModel;
        hCell.indexPath = indexPath;
        if (hCell.delegate == nil) {
            hCell.delegate = self;
        }
        @WeakObj(self);
        hCell.originalView.moreButtonClickedBlock=^(NSIndexPath *index){
            [selfWeak moreButtonClick:indexPath];
        };
        cell = hCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)moreButtonClick:(NSIndexPath *)indexPath
{
    if (indexPath) {
        LZMomentsViewModel *model = _dataArray[indexPath.row-2];
        model.isOpening = !model.isOpening;
        [_homeTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)showController:(NSInteger)tag{
    NSInteger type = [appDelegate.userModel.type integerValue];
    if (type == 3) {
        if (tag == 0) {
            DDPublishHomeworkController *publishVC = [[DDPublishHomeworkController alloc]initWithNibName:@"DDPublishHomeworkController" bundle:nil];
            [self.navigationController pushViewController:publishVC animated:YES];
        }else if (tag == 1)
        {
            DDSelectClssController *classVC = [[DDSelectClssController alloc]initWithNibName:@"DDSelectClssController" bundle:nil];
            [self.navigationController pushViewController:classVC animated:YES];
        }else
        {
            DDPublishNoticeController *noticeVC = [[DDPublishNoticeController alloc]initWithNibName:@"DDPublishNoticeController" bundle:nil];
            [self.navigationController pushViewController:noticeVC animated:YES];
        }
    }
    if (type == 1) {
        if (tag == 0) {
            DDTabBarController *tabController = (DDTabBarController *) appDelegate.window.rootViewController;
            tabController.selectedIndex = 1;
        }
        else if (tag == 1) {
            DDScoreInfoController *scoreVC = [[DDScoreInfoController alloc]initWithNibName:@"DDScoreInfoController" bundle:nil];
            [self.navigationController pushViewController:scoreVC animated:YES];
        }
        else if (tag == 2)
        {
            DDTabBarController *tabController = (DDTabBarController *) appDelegate.window.rootViewController;
            tabController.selectedIndex = 2;
            if ([NSStringFromClass([tabController.selectedViewController classForCoder]) isEqualToString:@"DDNavigationController"]) {
                DDNavigationController *navController = (DDNavigationController *)tabController.selectedViewController;
                UIViewController *rootController = [navController.viewControllers lastObject];
                if ([rootController isKindOfClass: [DDRoutineController class]]) {
                    DDRoutineController *routineVC = (DDRoutineController *)rootController;
                    routineVC.selectIndex = @"0";
                }
            }
            
        }
        else if (tag == 3)
        {
            DDTabBarController *tabController = (DDTabBarController *) appDelegate.window.rootViewController;
            tabController.selectedIndex = 2;
            if ([NSStringFromClass([tabController.selectedViewController classForCoder]) isEqualToString:@"DDNavigationController"]) {
                DDNavigationController *navController = (DDNavigationController *)tabController.selectedViewController;
                UIViewController *rootController = [navController.viewControllers lastObject];
                if ([rootController isKindOfClass: [DDRoutineController class]]) {
                    DDRoutineController *routineVC = (DDRoutineController *)rootController;
                    routineVC.selectIndex = @"1";
                }
            }
        }
    }
}


- (void)loadData{
    @WeakObj(self);
    [self Network_Post:@"index" tag:Index_Tag param:@{@"page":@(page)} success:^(id result) {
        [selfWeak.homeTable.mj_header endRefreshing];
        [selfWeak.homeTable.mj_footer endRefreshing];
        if ([result[@"code"]integerValue]==200) {
            NSMutableArray *array = [NSMutableArray new];
            for (NSDictionary *dic in result[DataKey][@"list"]) {
                LZMoments *model = [LZMoments new];
                model.iconName = [dic[@"pic"] isValidString]?[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"pic"]]:@"";
                model.name = dic[@"nickname"];
                model.msgContent = dic[@"message"];
                NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
                if ([dic[@"pic1"] isValidString]) {
                    [imageArray addObject:[dic[@"pic1"] isValidString]?[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"pic1"]]:@""];
                }
                if ([dic[@"pic2"] isValidString]) {
                    [imageArray addObject:[dic[@"pic2"] isValidString]?[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"pic2"]]:@""];
                }
                if ([dic[@"pic3"] isValidString]) {
                    [imageArray addObject:[dic[@"pic3"] isValidString]?[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"pic3"]]:@""];
                }
                model.picNamesArray = imageArray;
                //点赞
                if ([dic[@"cklikelist"]isKindOfClass:[NSArray class]]) {
                    NSMutableArray *tempLikeItems = [NSMutableArray new];
                    for (NSDictionary *zanDic in dic[@"cklikelist"]) {
                        LZMomentsCellLikeItemModel *likeModel = [[LZMomentsCellLikeItemModel alloc] init];
                        likeModel.userId = zanDic[@"uid"];
                        likeModel.userName = zanDic[@"nickname"];
                        [tempLikeItems addObject:likeModel];
                    }
                     model.likeItemsArray = [tempLikeItems copy];
                }
                if ([dic[@"replylist"]isKindOfClass:[NSArray class]]) {
                     NSMutableArray *tempComments = [NSMutableArray new];
                    for (NSDictionary *commentDic in dic[@"replylist"]) {
                        LZMomentsCellCommentItemModel *commentItemModel = [LZMomentsCellCommentItemModel new];
                        commentItemModel.firstUserName = commentDic[@"nickname"];
                        commentItemModel.firstUserId = commentDic[@"id"];
                        commentItemModel.commentString =commentDic[@"comment"];
                        [tempComments addObject:commentItemModel];
                    }
                     model.commentItemsArray = [tempComments copy];
                }
                LZMomentsViewModel *momentsViewModel = [LZMomentsViewModel viewModelWithStatus:model];
                [array addObject:momentsViewModel];
            }
            selfWeak.homeModel.usertype = result[DataKey][@"usertype"];
            selfWeak.homeModel.totalcount = result[DataKey][@"totalcount"];
            selfWeak.homeModel.totalpages = result[DataKey][@"totalpages"];
            selfWeak.homeModel.lunbolist = result[DataKey][@"lunbolist"];
            if (page==1) {
                selfWeak.dataArray = array;
            }
            else
            {
                [selfWeak.dataArray addObjectsFromArray:array];
            }
            [selfWeak.homeTable reloadData];
        }
    } failure:^(NSError *error) {
        [selfWeak.homeTable.mj_header endRefreshing];
        [selfWeak.homeTable.mj_footer endRefreshing];
        [selfWeak showErrorHUD:@"网络异常"];
    }];
}

#pragma mark - LZMomentsCellDelegate
- (void)didClickLickButtonInCell:(LZMomentsCell *)cell
{
    NSIndexPath *indexPath = [self.homeTable indexPathForCell:cell];
    [self.homeTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (LZMomentsListViewModel *)statusListViewModel {
    if (_statusListViewModel == nil) {
        _statusListViewModel = [[LZMomentsListViewModel alloc] init];
    }
    return _statusListViewModel;
}

- (void)didClickcCommentButtonInCell:(LZMomentsCell *)cell
{
    
    if (!_chatKeyBoard) {
        self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
        self.chatKeyBoard.delegate = self;
        self.chatKeyBoard.allowVoice = NO;
        self.chatKeyBoard.allowFace = NO;
        self.chatKeyBoard.allowMore = NO;
        self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        [self.view addSubview:self.chatKeyBoard];
    }
    [self.chatKeyBoard keyboardUpforComment];
}

/**
 *  键盘回调，回答问题
 *
 *  @param text text description
 */
- (void)chatKeyBoardSendText:(NSString *)text
{
    if ([text isValidString]) {
        
    }
    else{
        
    }
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
