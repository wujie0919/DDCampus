//
//  DDScoreInfoListController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreInfoListController.h"
#import "DDScoreTrendCell.h"
#import "DDScoreTeacherCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DDStudentScoreInfoCell.h"
#import "DDScoreDetailsController.h"
#import "DDCurveViewController.h"

static NSString * const trend = @"trend";
static NSString * const teacher = @"teacher";
static NSString * const studentcell = @"studentcell";

@interface DDScoreInfoListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger type;
@end

@implementation DDScoreInfoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    @WeakObj(self);
    _array = [NSMutableArray new];
    self.view.backgroundColor = [UIColor redColor];
    _dataArray = [NSMutableArray new];
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (selfWeak.index==0) {
            if (selfWeak.type ==3) {
                [selfWeak getScoreWithTeacher];
            }
            else{
                [selfWeak loadData];
            }
        }
        else{
            if (selfWeak.type ==3) {
                [selfWeak getclassscoretrend];
            }else
            {
                [selfWeak loadScoreRend];
            }
            
        }
    }];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDScoreTrendCell" bundle:nil] forCellReuseIdentifier:trend];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDScoreTeacherCell" bundle:nil] forCellReuseIdentifier:teacher];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDStudentScoreInfoCell" bundle:nil] forCellReuseIdentifier:studentcell];
    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _index==0?_array.count:_dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        if (_type==3) {
            DDScoreTeacherCell *cell = (DDScoreTeacherCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            
            return cell.listView.height+10;
        }
        else
        {
            DDStudentScoreInfoCell *scell = (DDStudentScoreInfoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            
            return scell.scoreView.height+10;
        }
    }
    else
        return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index==0) {
        if (_type==3) {
            DDScoreTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:teacher];
            [cell.listView setData:_array[indexPath.row]];
            cell.backgroundColor =RGB(237, 238, 239);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            DDStudentScoreInfoCell *scell = [tableView dequeueReusableCellWithIdentifier:studentcell];
            [scell.scoreView setData:_array[indexPath.row]];
            scell.backgroundColor =RGB(237, 238, 239);
            scell.selectionStyle = UITableViewCellSelectionStyleNone;
            return scell;
        }
    }
    else
    {
        DDScoreTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:trend];
        [cell.trendView setData:_dataArray[indexPath.row]];
        cell.backgroundColor = RGB(237, 238, 239);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_index == 1) {
        NSDictionary *dict = _dataArray[indexPath.row];
        DDCurveViewController *curveVC = [[DDCurveViewController alloc]initWithNibName:@"DDCurveViewController" bundle:nil];
        curveVC.dic = dict;
        curveVC.classid = _classId;
        [self.navigationController pushViewController:curveVC animated:YES];
    }
    else
    {
        if (_type == 3) {
            NSDictionary *dict = _array[indexPath.row];
            DDScoreDetailsController *sDetailsVC = [[DDScoreDetailsController alloc]initWithNibName:@"DDScoreDetailsController" bundle:nil];
            sDetailsVC.scorethemeid = [NSString stringWithFormat:@"%@",dict[@"id"]];
            sDetailsVC.title = dict[@"name"];
            [self.navigationController pushViewController:sDetailsVC animated:YES];
        }
    }
}

- (void)loadData
{
    @WeakObj(self);
    [self Network_Post:@"getscore" tag:Getscore_Tag
                 param:nil
               success:^(id result) {
                   [selfWeak.dataTable.mj_header endRefreshing];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                       if ([result[DataKey]isKindOfClass:[NSArray class]]) {
                           [data addObjectsFromArray:result[DataKey]];
                       }
                       selfWeak.array = data;
                       [selfWeak.dataTable reloadData];
                   }
               } failure:^(NSError *error) {
                   
               }];
}

- (void)getScoreWithTeacher
{
    @WeakObj(self);
    [self Network_Post:@"getclassscore" tag:Getclassscore_Tag
                 param:@{@"classid":_classId}
               success:^(id result) {
                   [selfWeak.dataTable.mj_header endRefreshing];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                       if ([result[DataKey]isKindOfClass:[NSArray class]]) {
                           [data addObjectsFromArray:result[DataKey]];
                       }
                       selfWeak.array = data;
                       [selfWeak.dataTable reloadData];
                   }
                   else
                   {
                       [MBProgressHUD showError:result[@"message"]];
                   }
               } failure:^(NSError *error) {
                   [MBProgressHUD showError:@"网络异常"];
               }];
}

- (void)loadScoreRend
{
    @WeakObj(self);
    [self Network_Post:@"getscoretrend"
                   tag:Getscoretrend_Tag
                 param:nil
               success:^(id result) {
                   [selfWeak.dataTable.mj_header endRefreshing];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                       if ([result[DataKey]isKindOfClass:[NSArray class]]) {
                           [data addObjectsFromArray:result[DataKey]];
                       }
                       selfWeak.dataArray = data;
                       [selfWeak.dataTable reloadData];
                   }
                   else
                   {
                       [MBProgressHUD showError:result[@"message"]];
                   }
               } failure:^(NSError *error) {
                    [MBProgressHUD showError:@"网络异常"];
               }];
}

- (void)getclassscoretrend
{
     @WeakObj(self);
    [self Network_Post:@"getclassscoretrend" tag:Getclassscoretrend_tag
                 param:@{@"classid":_classId}
               success:^(id result) {
                   [selfWeak.dataTable.mj_header endRefreshing];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                       if ([result[DataKey]isKindOfClass:[NSArray class]]) {
                           [data addObjectsFromArray:result[DataKey]];
                       }
                       selfWeak.dataArray = data;
                       [selfWeak.dataTable reloadData];
                   }
                   else
                   {
                       [MBProgressHUD showError:result[@"message"]];
                   }
               } failure:^(NSError *error) {
                   [MBProgressHUD showError:@"网络异常"];
               }];
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    [self.dataTable reloadData];
    _type = [appDelegate.userModel.type integerValue];
    if (index == 0) {
        if (_type == 3) {
            [self getScoreWithTeacher];
        }
        else
        {
            [self loadData];
        }
    }
    else
    {
        if (self.type ==3) {
            [self getclassscoretrend];
        }else
        {
            [self loadScoreRend];
        }
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
