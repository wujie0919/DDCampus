//
//  DDGroupMemberController.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupMemberController.h"
#import "DDGroupMemberUserViewCell.h"

static NSString * const userCell = @"userCell";

@interface DDGroupMemberController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, copy) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, copy) NSDictionary *groupDic;
@end

@implementation DDGroupMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _array = [NSMutableArray new];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupMemberUserViewCell" bundle:nil] forCellReuseIdentifier:userCell];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [_dataTable endEditing:YES];
}

- (void)setData:(NSDictionary *)dic group:(NSDictionary * _Nonnull)gDic
{
    _groupDic = gDic;
//    if ([dic[@"groupuserlist"]isKindOfClass:[NSArray class]]) {
//        _array = [NSMutableArray arrayWithArray:dic[@"groupuserlist"]];
//        [_dataTable reloadData];
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDGroupMemberUserViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userCell];
    [cell setCellData:_array[indexPath.row]];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =_array[indexPath.row];
    if ([dic[@"uid"]isEqualToString:appDelegate.userModel.user_id]) {
        return UITableViewCellEditingStyleNone;
    }
    return   UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        _index = indexPath;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除该成员？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        _index = nil;
    }
    else
    {
        [_dataTable endEditing:YES];
        [self showLoadHUD:@"删除中"];
        @WeakObj(self);
        [self Network_Post:@"do_delgroupuser" tag:Do_delgroupuser_Tag
                     param:@{@"groupid":_groupDic[@"groupid"]} success:^(id result) {
                         [selfWeak hideHUD];
                         if ([result[@"code"]integerValue]==200) {
                             [selfWeak showSuccessHUD:@"删除成功"];
                             [selfWeak.array removeObjectAtIndex:selfWeak.index.row];
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
}

- (void)loadData
{
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"getgroupuserlist" tag:Getgroupuserlist_Tag
                 param:@{@"groupid":_groupDic[@"groupid"]} success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
                         if ([result[DataKey][@"groupuserlist"]isKindOfClass:[NSArray class]]) {
                             [dataArray addObjectsFromArray:result[DataKey][@"groupuserlist"]];
                         }
                         selfWeak.array = dataArray;
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
