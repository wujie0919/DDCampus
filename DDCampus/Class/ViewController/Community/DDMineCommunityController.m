//
//  DDMineCommunityController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMineCommunityController.h"
#import "DDCommunityHeaderView.h"
#import "DDCommounityModel.h"
#import "LZMomentsCell.h"
#import "LZMomentsViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LZMomentsListViewModel.h"
#import "DDCommentView.h"
#import "DDFindGroupController.h"
#import "DDGroupInfoController.h"

static NSString * const homeCell = @"homeCell";

@interface DDMineCommunityController ()<UITextViewDelegate,LZMomentsCellDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSLock *_lock;
}
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) DDCommunityHeaderView *headerView;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableDictionary *pageDic;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *staticDataKey;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) DDCommentView *chatKeyBoard;
@property (nonatomic, copy) NSString *rpid;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) DDCommounityModel *commounityModel;
@end

@implementation DDMineCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的社区";
    [self setBackBarButtonItem];
    _type = @"1";
    _staticDataKey = _type;
    _page = 1;
    [self showRightTitle];
    _pageDic = [NSMutableDictionary dictionary];
    _dataDic = [NSMutableDictionary dictionary];
    [_pageDic setValue:@(_page) forKey:_type];
    @WeakObj(self);
    _headerView = [DDCommunityHeaderView headerView:CGRectMake(0, 0, SCREEN_WIDTH, 45) selectBlock:^(NSInteger tag, DDCommounityModel *model) {
        selfWeak.type = [NSString stringWithFormat:@"%ld",(long)model.type];
        selfWeak.commounityModel = model;
        if (model.type == 3) {
            selfWeak.groupId = [NSString stringWithFormat:@"%ld",(long)model.groupId];
            selfWeak.staticDataKey = selfWeak.groupId;
            [selfWeak.pageDic setObject:@(1) forKey:selfWeak.groupId];
        }
        else
        {
            selfWeak.staticDataKey = selfWeak.type;
            [selfWeak.pageDic setObject:@(1) forKey:selfWeak.staticDataKey];
        }
        NSMutableArray *array = selfWeak.dataDic[selfWeak.staticDataKey];
        if (array.count<=0) {
            
            
            [selfWeak loadData];
            [selfWeak showRightTitle];
        }else
        {
            [selfWeak showRightTitle];
            [selfWeak.dataTable reloadData];
        }
    }];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(0);
        make.left.equalTo(selfWeak.view).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
        make.height.mas_equalTo(45);
    }];
    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.headerView.mas_bottom).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
        make.left.equalTo(selfWeak.view).offset(0);
        make.bottom.equalTo(selfWeak.view).offset(0);
    }];
    _lock = [[NSLock alloc]init];
    [_dataTable registerClass:[LZMomentsCell class] forCellReuseIdentifier:homeCell];
    [self loadData];
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak.pageDic setObject:@(1) forKey:selfWeak.type];
        [selfWeak loadData];
    }];
    
    _dataTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        selfWeak.page++;
        [selfWeak.pageDic setValue:@(selfWeak.page) forKey:selfWeak.staticDataKey];
        [selfWeak loadData];
    }];
    
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(commentClick:)
                                                 name:LZCommentClickedNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LZCommentClickedNotification object:nil];
}

- (void)keyboardHide:(NSNotification *)notif {
    _chatKeyBoard.hidden = YES;
    _chatKeyBoard.textView.text = @"";
    if (_chatKeyBoard.hidden == YES) {
        return;
    }
}

- (void)commentClick:(NSNotification *)notification
{
    LZMomentsViewModel *momentsViewModel = (LZMomentsViewModel *)notification.userInfo[LZCommentViewNoticationKey];
    _index = [NSIndexPath indexPathForRow:[_dataDic[_staticDataKey] indexOfObject:momentsViewModel] inSection:0];
    LZMomentsCellCommentItemModel *model = (LZMomentsCellCommentItemModel *)notification.userInfo[LZCommentClickedNotificationKey];
    _rpid = model.rpid;
    if (!_chatKeyBoard) {
        _chatKeyBoard = [DDCommentView initComment:CGRectMake(0, SCREEN_HEIGHT-160, SCREEN_WIDTH, 50)];
        _chatKeyBoard.backgroundColor = [UIColor whiteColor];
        _chatKeyBoard.textView.delegate = self;
        [_chatKeyBoard.textView becomeFirstResponder];
        [self.view addSubview:_chatKeyBoard];
    }
    if (_chatKeyBoard.hidden) {
        _chatKeyBoard.hidden = NO;
        [_chatKeyBoard.textView becomeFirstResponder];
    }
    _chatKeyBoard.textView.text=[NSString stringWithFormat:@"回复%@",model.firstUserName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataDic[_staticDataKey] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZMomentsCell *hCell = [tableView dequeueReusableCellWithIdentifier:homeCell];
    LZMomentsViewModel *viewModel = _dataDic[_staticDataKey][indexPath.row];
    hCell.viewModel = viewModel;
    hCell.indexPath = indexPath;
    if (hCell.delegate == nil) {
        hCell.delegate = self;
    }
    @WeakObj(self);
    hCell.originalView.moreButtonClickedBlock=^(NSIndexPath *index){
        [selfWeak moreButtonClick:indexPath];
    };
    return hCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakObj(self);
    return [tableView fd_heightForCellWithIdentifier:homeCell cacheByIndexPath:indexPath configuration:^(LZMomentsCell *cell) {
        
        // 在这个block中，重新cell配置数据源
        LZMomentsViewModel *viewModel =  selfWeak.dataDic[selfWeak.staticDataKey][indexPath.row];
        cell.viewModel = viewModel;
    }];
}

- (void)moreButtonClick:(NSIndexPath *)indexPath
{
    if (indexPath) {
        LZMomentsViewModel *model = _dataDic[_staticDataKey][indexPath.row];
        model.isOpening = !model.isOpening;
        [_dataTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)didClickLickButtonInCell:(LZMomentsCell *)cell
{
    _index = [self.dataTable indexPathForCell:cell];
    LZMomentsViewModel *model = _dataDic[_staticDataKey][_index.row];
    [self showLoadHUD:@"提交中..."];
    @WeakObj(self);
    [self Network_Post:@"do_forumpostlike" tag:Do_forumpostlike_Tag
                 param:@{@"pid":model.status.pid}
               success:^(id result) {
                   [selfWeak hideHUD];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *tempLikeItems = [NSMutableArray new];
                       [tempLikeItems addObjectsFromArray:model.status.likeItemsArray];
                       LZMomentsCellLikeItemModel *likeModel = [[LZMomentsCellLikeItemModel alloc] init];
                       likeModel.userId = appDelegate.userModel.user_id;
                       likeModel.userName = appDelegate.userModel.nickname;
                       [tempLikeItems addObject:likeModel];
                       model.status.likeItemsArray = [tempLikeItems copy];
                       NSMutableArray *oldArray = [selfWeak.dataDic valueForKey:selfWeak.staticDataKey];
                       
                       [oldArray replaceObjectAtIndex:_index.row withObject:model];
                       [selfWeak.dataDic setValue:oldArray forKey:selfWeak.staticDataKey];
                       [selfWeak.dataTable reloadRowsAtIndexPaths:@[_index] withRowAnimation:UITableViewRowAnimationNone];
                   }
                   else
                   {
                       [selfWeak showErrorHUD:result[@"message"]];
                   }
                   selfWeak.index = nil;
                   
               } failure:^(NSError *error) {
                   selfWeak.index = nil;
                   [selfWeak hideHUD];
               }];
}
- (void)didClickcCommentButtonInCell:(LZMomentsCell *)cell{
    _index = [self.dataTable indexPathForCell:cell];
    if (!_chatKeyBoard) {
        _chatKeyBoard = [DDCommentView initComment:CGRectMake(0, SCREEN_HEIGHT-160, SCREEN_WIDTH, 50)];
        _chatKeyBoard.backgroundColor = [UIColor whiteColor];
        _chatKeyBoard.textView.delegate = self;
        [_chatKeyBoard.textView becomeFirstResponder];
        [self.view addSubview:_chatKeyBoard];
    }
    if (_chatKeyBoard.hidden) {
        _chatKeyBoard.hidden = NO;
        [_chatKeyBoard.textView becomeFirstResponder];
    }
}

- (void)loadData
{
    @WeakObj(self);
    [_lock lock];
    [self Network_Post:@"getforumpost"
                   tag:Getforumpost_Tag
                 param:@{@"pagesize":@(20),
                         @"page":_pageDic[_staticDataKey],
                         @"type":_type,
                         @"groupid":_groupId?_groupId:@""} success:^(id result) {
                             [selfWeak.dataTable.mj_header endRefreshing];
                             [selfWeak.dataTable.mj_footer endRefreshing];
                             NSMutableArray *array = [NSMutableArray new];
                             if ([result[@"code"]integerValue]==200) {
                                 if ([result[DataKey][@"group"]isKindOfClass:[NSArray class]]) {
                                     selfWeak.headerView.dataSource =[NSMutableArray arrayWithArray:result[DataKey][@"group"]];
                                 }
                                 
                                 if ([result[DataKey][@"list"]isKindOfClass:[NSArray class]]) {
                                     for (NSDictionary *dic in result[DataKey][@"list"]) {
                                         LZMoments *model = [LZMoments new];
                                         model.time = [NSDate compareWithOther:dic[@"dateline"] day:NO];
                                         model.pid = [NSString stringWithFormat:@"%@",dic[@"id"]];
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
                                                 commentItemModel.rpid = [NSString stringWithFormat:@"%@",commentDic[@"rpid"]];
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
                                     
                                 }
                             }else
                             {
                                 [self showErrorHUD:result[@"message"]];
                             }
                             NSInteger spage = [[selfWeak.pageDic valueForKey:selfWeak.staticDataKey]integerValue];
                             if (spage==1) {
                                 [selfWeak.dataDic setValue:array forKey:selfWeak.staticDataKey];
                             }
                             else
                             {
                                 NSMutableArray *oldArray = [selfWeak.dataDic valueForKey:selfWeak.staticDataKey];
                                 [oldArray addObjectsFromArray:array];
                                 [selfWeak.dataDic setValue:oldArray forKey:selfWeak.staticDataKey];
                             }
                             [_lock unlock];
                             [selfWeak.dataTable reloadData];
                         } failure:^(NSError *error) {
                             [selfWeak.dataTable.mj_header endRefreshing];
                             [selfWeak.dataTable.mj_footer endRefreshing];
                             [_lock unlock];
                         }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self chatKeyBoardSendText:textView.text];
        return NO;
    }
    return YES;
}
/**
 *  键盘回调，回答问题
 *
 *  @param text text description
 */
- (void)chatKeyBoardSendText:(NSString *)text
{
    if ([text isValidString]) {
        
        LZMomentsViewModel *model=model = _dataDic[_staticDataKey][_index.row];;
        
        if (![_rpid isValidString]) {
            _rpid = @"0";
        }
        [self.view endEditing:YES];
        [self showLoadHUD:@"提交中..."];
        @WeakObj(self);
        [self Network_Post:@"do_forumreply" tag:Do_forumreply_Tag
                     param:@{@"pid":model.status.pid,
                             @"comment":text,
                             @"rpid":_rpid}
                   success:^(id result) {
                       
                       if ([result[@"code"]integerValue]==200) {
                           NSMutableArray *tempComments = [NSMutableArray new];
                           [tempComments addObjectsFromArray:model.status.commentItemsArray];
                           LZMomentsCellCommentItemModel *commentItemModel = [LZMomentsCellCommentItemModel new];
                           commentItemModel.firstUserName = appDelegate.userModel.nickname;
                           commentItemModel.firstUserId = appDelegate.userModel.user_id;
                           commentItemModel.commentString =text;
                           [tempComments addObject:commentItemModel];
                           model.status.commentItemsArray = [tempComments copy];
                           NSMutableArray *oldArray = [selfWeak.dataDic valueForKey:selfWeak.staticDataKey];
                           
                           [oldArray replaceObjectAtIndex:_index.row withObject:model];
                           [selfWeak.dataTable reloadRowsAtIndexPaths:@[_index] withRowAnimation:UITableViewRowAnimationNone];
                           
                       }
                       selfWeak.index = nil;
                       [selfWeak hideHUD];
                       selfWeak.rpid =@"0";
                   } failure:^(NSError *error) {
                       [selfWeak hideHUD];
                       selfWeak.index = nil;
                   }];
    }
    else{
        
    }
}

- (void)showRightTitle
{
//    if ([_type integerValue]!=3) {
//        
//        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
//        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _rightButton.backgroundColor = RGB(48, 185, 113);
//        _rightButton.frame = CGRectMake(0, 5, 100, 30);
//        _rightButton.layer.cornerRadius= 5;
//        _rightButton.layer.masksToBounds = YES;
//        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
//        _rightButton.layer.borderWidth = 1;
//        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
//        [_rightButton addTarget:self action:@selector(findGroup) forControlEvents:UIControlEventTouchUpInside];
//        [_rightButton setTitle:@"发现社区" forState:UIControlStateNormal];
//        
//    }else{
//        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _rightButton.backgroundColor = RGB(48, 185, 113);
//        _rightButton.frame = CGRectMake(0, 5, 100, 30);
//        _rightButton.layer.cornerRadius= 5;
//        _rightButton.layer.masksToBounds = YES;
//        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
//        _rightButton.layer.borderWidth = 1;
//        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
//        [_rightButton addTarget:self action:@selector(showGroupInfo) forControlEvents:UIControlEventTouchUpInside];
//        [_rightButton setTitle:@"群组资料" forState:UIControlStateNormal];
//    }
}

- (void)findGroup
{
    DDFindGroupController *findVC = [[DDFindGroupController alloc]initWithNibName:@"DDFindGroupController" bundle:nil];
    @WeakObj(self);
    findVC.joinBlock = ^()
    {
        [selfWeak loadData];
    };
    [self.navigationController pushViewController:findVC animated:YES];
}

- (void)showGroupInfo
{
    DDGroupInfoController *infoVc = [[DDGroupInfoController alloc]initWithNibName:@"DDGroupInfoController" bundle:nil];
    @WeakObj(self);
    infoVc.groupDic = _commounityModel.dic;
    infoVc.exitBlock = ^(){
        [selfWeak loadData];
    };
    [self.navigationController pushViewController:infoVc animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
