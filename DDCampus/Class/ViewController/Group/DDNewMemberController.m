//
//  DDNewMemberController.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNewMemberController.h"
#import "DDGroupJoinCell.h"
#import "DDJoinModel.h"

static NSString * const joincell = @"joinCell";

@interface DDNewMemberController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation DDNewMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"新的申请";
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupJoinCell" bundle:nil] forCellReuseIdentifier:joincell];
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
    DDGroupJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:joincell];
    [cell setValue:_dataArray[indexPath.row]];
    @WeakObj(self);
    cell.handler= ^(NSInteger status){
        [selfWeak option:status row:indexPath.row];
    };
    return cell;
}

- (void)loadData
{
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"getreviewgroupuser" tag:Getreviewgroupuser_Tag
                 param:@{@"groupid":_groupDic[@"groupid"]} success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         if ([result[DataKey][@"reviewuserlist"]isKindOfClass:[NSArray class]]) {
                             NSMutableArray *array = [NSMutableArray new];
                             for (NSDictionary *dic in result[DataKey][@"reviewuserlist"]) {
                                 DDJoinModel *model = [DDJoinModel new];
                                 model.uid = dic[@"uid"];
                                 model.sqdateline = dic[@"sqdateline"];
                                 model.joinId = dic[@"id"];
                                 model.nickname = dic[@"nickname"];
                                 model.pic= dic[@"pic"];
                                 model.status =@"0";
                                 [array addObject:model];
                             }
                             selfWeak.dataArray = array;
                             [selfWeak.dataTable reloadData];
                         }
                     }
                 } failure:^(NSError *error) {
                     
                 }];
}

- (void)option:(NSInteger)status row:(NSInteger)row
{
    DDJoinModel *model = _dataArray[row];
    if (status == 1) {
        model.status = @"1";
    }
    else
    {
        model.status = @"2";
    }
    @WeakObj(self);
    [self showLoadHUD:@"提交中..."];
    [self Network_Post:@"do_reviewgroupuser" tag:Do_reviewgroupuser_Tag
                 param:@{@"groupid":_groupDic[@"groupid"],
                         @"opuid":model.uid,
                         @"op":model.status}
               success:^(id result) {
                   [selfWeak hideHUD];
                   if ([result[@"code"]integerValue]==200) {
                       [selfWeak.dataArray replaceObjectAtIndex:row withObject:model];
                       [selfWeak.dataTable reloadData];
                   }
                   else
                   {
                       [selfWeak showErrorHUD:result[@"message"]];
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
