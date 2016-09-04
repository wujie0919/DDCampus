//
//  DDScoreDetailsController.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreDetailsController.h"
#import "DDScoreDetailsCell.h"
#import "DDScoreDetailOtherViewCell.h"
#import "DDEntryScoreController.h"

static NSString * const details=@"details";
static NSString * const otherCell = @"otherCell";
@interface DDScoreDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, copy) NSDictionary *dataDic;
@end

@implementation DDScoreDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDScoreDetailsCell" bundle:nil] forCellReuseIdentifier:details];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDScoreDetailOtherViewCell" bundle:nil] forCellReuseIdentifier:otherCell];
    @WeakObj(self);
    [self showLoadHUD:@"加载中..."];
    [self Network_Post:@"getscoredetail" tag:Getscoredetail_Tag param:@{@"scorethemeid":_scorethemeid} success:^(id result) {
        [selfWeak hideHUD];
        if ([result[@"code"]integerValue]==200) {
            selfWeak.dataDic = result[DataKey];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            if ([result[DataKey][@"list"]isKindOfClass:[NSArray class]]) {
                [array addObjectsFromArray:result[DataKey][@"list"]];
            }
            selfWeak.dataArray = array;
            [selfWeak.dataTable reloadData];
        }else
        {
            [selfWeak showErrorHUD:result[@"message"]];
        }
    } failure:^(NSError *error) {
        [selfWeak hideHUD];
        [selfWeak showErrorHUD:@"网络异常"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray[indexPath.row][@"score_sum"]integerValue]==0) {
        return 44;
    }
    DDScoreDetailsCell *cell = (DDScoreDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.detailsView.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray[indexPath.row][@"score_sum"]integerValue]==0) {
        DDScoreDetailOtherViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCell];
        cell.nameLabel.text = _dataArray[indexPath.row][@"student_name"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    DDScoreDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:details];
    [cell.detailsView setViewData:_dataArray[indexPath.row]];
    cell.backgroundColor = RGB(207, 208, 209);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DDEntryScoreController *entryVC = [[DDEntryScoreController alloc]initWithNibName:@"DDEntryScoreController" bundle:nil];
    entryVC.dict = _dataArray[indexPath.row];
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<_dataArray.count;i++) {
        NSDictionary *dic = _dataArray[i];
        if (indexPath.row == i) {
            continue;
        }
        if ([_dataArray[indexPath.row][@"score_sum"]integerValue]==0) {
            [data addObject:dic];
        }
    }
    [data insertObject:_dataArray[indexPath.row] atIndex:0];
    entryVC.dataArray = data;
    entryVC.dataDic = self.dataDic;
    entryVC.headerTitle = self.title;
    [self.navigationController pushViewController:entryVC animated:YES];
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
