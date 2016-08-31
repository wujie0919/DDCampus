//
//  DDSetGroupManagerController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSetGroupManagerController.h"
#import "DDGroupApplyTableCell.h"
#import "DDGroupSetManagerModel.h"

static NSString * const applyCell = @"applyCell";


@interface DDSetGroupManagerController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, copy) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, copy) NSDictionary *groupDic;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation DDSetGroupManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"管理员设置";
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupApplyTableCell" bundle:nil] forCellReuseIdentifier:applyCell];
    _dataTable.rowHeight = 73;
    _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _rightButton.backgroundColor = RGB(48, 185, 113);
    _rightButton.frame = CGRectMake(0, 5, 60, 30);
    _rightButton.layer.cornerRadius= 5;
    _rightButton.layer.masksToBounds = YES;
    _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _rightButton.layer.borderWidth = 1;
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [_rightButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"确认" forState:UIControlStateNormal];
    [self loadData];
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
    DDGroupApplyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:applyCell];
    [cell setData:_array[indexPath.row]];
    cell.cancelBlock = ^(){
        [self cancelManager:indexPath.row];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (DDGroupSetManagerModel *m in _array) {
        m.select = NO;
    }
    DDGroupSetManagerModel *model = _array[indexPath.row];
    model.select = !model.select;
    _index = indexPath;
    [_array replaceObjectAtIndex:indexPath.row withObject:model];
    [tableView reloadData];
    if (!self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    }
    
}

- (void)cancelManager:(NSInteger)row
{
    DDGroupSetManagerModel *model = _array[_index.row];
    NSString *message = [NSString stringWithFormat:@"你确定取消%@的管理员吗？",model.nickname];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"取消管理员" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1002;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        DDGroupSetManagerModel *model = _array[_index.row];
        if (alertView.tag == 1002) {
            
            model.level = @"2";
            [self showLoadHUD:@"取消中..."];
            @WeakObj(self);
            [self Network_Post:@"do_admingroup" tag:Do_admingroup_Tag
                         param:@{@"groupid":_groupDic[@"groupid"],
                                 @"admin_uid":model.uid,
                                 @"op":model.level} success:^(id result) {
                                     [selfWeak hideHUD];
                                     if ([result[@"code"]integerValue]==200) {
                                         [selfWeak showSuccessHUD:@"取消成功"];
                                         [selfWeak.array replaceObjectAtIndex:selfWeak.index.row withObject:model];
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
        else
        {
            model.level = @"1";
            [self showLoadHUD:@"设置中..."];
            @WeakObj(self);
            [self Network_Post:@"do_admingroup" tag:Do_admingroup_Tag
                         param:@{@"groupid":_groupDic[@"groupid"],
                                 @"admin_uid":model.uid,
                                 @"op":@(1)} success:^(id result) {
                                     [selfWeak hideHUD];
                                     if ([result[@"code"]integerValue]==200) {
                                         [selfWeak showSuccessHUD:@"设置成功"];
                                         [selfWeak.array replaceObjectAtIndex:selfWeak.index.row withObject:model];
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
}

- (void)sureClick
{
    DDGroupSetManagerModel *model = _array[_index.row];
    NSString *message = [NSString stringWithFormat:@"你确定设置%@为管理员吗？",model.nickname];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"管理员设置" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1001;
    [alert show];
    
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
                             for (NSDictionary *dics in result[DataKey][@"groupuserlist"]) {
                                 DDGroupSetManagerModel *model = [DDGroupSetManagerModel new];
                                 model.userId = dics[@"id"];
                                 model.uid = dics[@"uid"];
                                 model.level = dics[@"level"];
                                 model.joindateline = dics[@"joindateline"];
                                 model.sqdateline = dics[@"sqdateline"];
                                 model.nickname = dics[@"nickname"];
                                 model.pic = dics[@"pic"];
                                 [dataArray addObject:model];
                             }
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
