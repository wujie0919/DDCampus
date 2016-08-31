//
//  DDTransferGroupController.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTransferGroupController.h"
#import "TransferGroupCell.h"
#import "DDGroupSetManagerModel.h"

static NSString * const transfer = @"transfer";

@interface DDTransferGroupController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation DDTransferGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"转让群主";
    _dataTable.rowHeight = 78;
    [_dataTable registerNib:[UINib nibWithNibName:@"TransferGroupCell" bundle:nil] forCellReuseIdentifier:transfer];
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
    TransferGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:transfer];
    [cell setData:_array[indexPath.row]];
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

- (void)sureClick
{
    DDGroupSetManagerModel *model = _array[_index.row];
    NSString *message = [NSString stringWithFormat:@"你确定把该群组转让给%@吗？",model.nickname];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"转让群主" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        DDGroupSetManagerModel *model = _array[_index.row];
        @WeakObj(self);
        [self showLoadHUD:@"转让中..."];
        [self Network_Post:@"do_transfergroup" tag:Do_transfergroup_Tag
                     param:@{@"groupid":_groupDic[@"groupid"],
                             @"transfer_uid":model.uid}
                   success:^(id result) {
                       [selfWeak hideHUD];
                       if ([result[@"code"]integerValue]==200) {
                           [selfWeak showSuccessHUD:@"转让成功"];
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
