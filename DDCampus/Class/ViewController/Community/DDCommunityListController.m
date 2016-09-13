//
//  DDCommunityListController.m
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityListController.h"
#import "LZMomentsCell.h"
#import "LZMomentsViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "LZMomentsListViewModel.h"
#import "ChatKeyBoard.h"


static NSString *const homeCell =@"homeCell";

@interface DDCommunityListController ()<UITableViewDelegate,UITableViewDataSource,LZMomentsCellDelegate,ChatKeyBoardDelegate>
{
    NSInteger page;
}
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (weak, nonatomic) IBOutlet UITableView *communityTable;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSMutableDictionary *pageDic;
@property (nonatomic, strong) LZMomentsListViewModel *statusListViewModel;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *dicKey;
@end

@implementation DDCommunityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _communityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _data = [NSMutableDictionary dictionaryWithCapacity:0];
    _pageDic = [NSMutableDictionary dictionaryWithCapacity:0];
    _communityTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-160);
    [_communityTable registerClass:[LZMomentsCell class] forCellReuseIdentifier:homeCell];
    @WeakObj(self);
    _communityTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1;
        [selfWeak.pageDic setValue:@(page) forKey:@(_index).stringValue];
        [selfWeak loadData];
    }];
    
    _communityTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page = [self.pageDic[@(_index).stringValue]integerValue];
        page++;
        [selfWeak.pageDic setValue:@(page) forKey:@(_index).stringValue];
        [selfWeak loadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    _type = [NSString stringWithFormat:@"%@",_groupDic[@"type"]];
    _dicKey = _type;
    _groupId = [NSString stringWithFormat:@"%@",_groupDic[@"groupid"]];
    if (![_type isValidString]) {
        _type = @"1";
    }
    if ([_dicKey isEqualToString:@"3"]) {
        _dicKey = _groupId;
    }
    [self.communityTable reloadData];
    if ([_data[_dicKey] count]<=0) {
        page = 1;
        [_pageDic setValue:@(page) forKey:_dicKey];
        [self loadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data[_dicKey] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZMomentsCell *hCell = [tableView dequeueReusableCellWithIdentifier:homeCell];
    LZMomentsViewModel *viewModel = _data[_dicKey][indexPath.row];
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
    return [tableView fd_heightForCellWithIdentifier:homeCell cacheByIndexPath:indexPath configuration:^(LZMomentsCell *cell) {
        
        // 在这个block中，重新cell配置数据源
        LZMomentsViewModel *viewModel =  _data[_dicKey][indexPath.row];
        cell.viewModel = viewModel;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)moreButtonClick:(NSIndexPath *)indexPath
{
    if (indexPath) {
        LZMomentsViewModel *model = _data[_dicKey][indexPath.row];
        model.isOpening = !model.isOpening;
        [_communityTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)loadData
{
    @WeakObj(self);
    [self Network_Post:@"getforumpost"
                   tag:Getforumpost_Tag
                 param:@{@"pagesize":@(20),
                         @"page":@(page),
                         @"type":_type,
                         @"groupid":_groupId?_groupId:@""} success:^(id result) {
                             [selfWeak.communityTable.mj_header endRefreshing];
                             [selfWeak.communityTable.mj_footer endRefreshing];
                             if ([result[@"code"]integerValue]==200) {
                                 NSMutableArray *array = [NSMutableArray new];
                                 if ([result[DataKey][@"list"]isKindOfClass:[NSArray class]]) {
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
                                     [selfWeak.data setValue:array forKey:selfWeak.dicKey];
                                     [selfWeak.communityTable reloadData];
                                 }
                             }else
                             {
                                 [self showErrorHUD:result[@"message"]];
                             }
                 } failure:^(NSError *error) {
                     [selfWeak.communityTable.mj_header endRefreshing];
                     [selfWeak.communityTable.mj_footer endRefreshing];
                 }];
}

#pragma mark - LZMomentsCellDelegate
- (void)didClickLickButtonInCell:(LZMomentsCell *)cell
{
    NSIndexPath *indexPath = [self.communityTable indexPathForCell:cell];
    [self.statusListViewModel didClickLickButtonInCellWithIndexPath:indexPath success:^{
        [self.communityTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^{
        
    }];
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
        self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
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
 *  @param text <#text description#>
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
