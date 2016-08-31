//
//  DDAllowJoinGroupController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDAllowJoinGroupController.h"
#import "DDGroupJoinCell.h"
#import "DDJoinModel.h"

static NSString * const appleyCell = @"appleyCell";

@interface DDAllowJoinGroupController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DDAllowJoinGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"新的申请";
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupJoinCell" bundle:nil] forCellReuseIdentifier:appleyCell];
    _dataTable.rowHeight = 73;
    @WeakObj(self);
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfWeak loadData];
    }];
    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDGroupJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:appleyCell];
    [cell setValue:_dataArray[indexPath.row]];
    @WeakObj(self);
    cell.handler = ^(NSInteger flg){
        [selfWeak option:flg row:indexPath.row];
    };
    return cell;
}

- (void)loadData{
    @WeakObj(self);
    [self showLoadHUD:@"加载中..."];
    [self Network_Post:@"getreviewgroupuser"
                   tag:Getreviewgroupuser_Tag
                 param:@{@"groupid":@""} success:^(id result) {
                     [selfWeak.dataTable.mj_header endRefreshing];
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         if ([result[DataKey][@"reviewuserlist"]isKindOfClass:[NSArray class]]) {
                             NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                             for (NSDictionary *dic in result[DataKey][@"reviewuserlist"]) {
                                 DDJoinModel *model = [DDJoinModel new];
                                 model.joinId = dic[@"id"];
                                 model.uid = dic[@"uid"];
                                 model.joindateline = dic[@"joindateline"];
                                 model.nickname = dic[@"nickname"];
                                 model.pic = dic[@"pic"];
                                 model.sqdateline = dic[@"sqdateline"];
                                 [array addObject:model];
                             }
                             selfWeak.dataArray = array;
                             [selfWeak.dataTable reloadData];
                         }
                     }else
                     {
                         [selfWeak showErrorHUD:result[@"message"]];
                     }
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                     [selfWeak showErrorHUD:@"网络异常"];
                 }];
}

- (void)option:(NSInteger)status row:(NSInteger)row
{
    @WeakObj(self);
    DDJoinModel *joiModel = _dataArray[row];
    [self showLoadHUD:@"提交中..."];
    [self Network_Post:@"do_reviewgroupuser" tag:Do_reviewgroupuser_Tag
                 param:@{@"groupid":@"",
                         @"opuid":joiModel.uid,
                         @"op":@(status)} success:^(id result) {
                             [selfWeak hideHUD];
                             [selfWeak showSuccessHUD:result[@"message"]];
                             if ([result[@"code"]integerValue]==200) {
                                 joiModel.status = [NSString stringWithFormat:@"%ld",(long)status];
                                 [selfWeak.dataArray replaceObjectAtIndex:row withObject:joiModel];
                                 [selfWeak.dataTable reloadData];
                             }
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                     [selfWeak showSuccessHUD:@"网络异常"];
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
