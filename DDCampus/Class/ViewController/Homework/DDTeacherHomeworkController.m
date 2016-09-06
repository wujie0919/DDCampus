//
//  DDTeacherHomeworkController.m
//  DDCampus
//
//  Created by wu on 16/9/6.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDTeacherHomeworkController.h"
#import "DDHomeworkModel.h"
#import "DDHomeworkCell.h"
#import "DDHomeWorkDetailsController.h"

static NSString * const homeworkCell = @"homeworkCell";
static NSInteger const pagesize = 5;

@interface DDTeacherHomeworkController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *dataTable;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DDTeacherHomeworkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDHomeworkCell" bundle:nil] forCellReuseIdentifier:homeworkCell];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    page = 1;
    @WeakObj(self);
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfWeak loadData];
    }];
    _dataTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [selfWeak loadData];
    }];
    self.title = @"作业";
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDHomeworkCell *hCell =(DDHomeworkCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return hCell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDHomeworkCell *cell = [tableView dequeueReusableCellWithIdentifier:homeworkCell];
    NSInteger row = indexPath.row;
    if (row%2==0) {
        cell.title_label.textColor = RGB(246, 132, 0);
        cell.teacher_label.textColor = RGB(246, 132, 0);
    }else
    {
        cell.title_label.textColor = RGB(115, 149, 252);
        cell.teacher_label.textColor = RGB(115, 149, 252);
    }
    [cell setData:_dataArray[row] row:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDHomeWorkDetailsController *detailsVC = [[DDHomeWorkDetailsController alloc]initWithNibName:@"DDHomeWorkDetailsController" bundle:nil];
    detailsVC.homeworkModel = _dataArray[indexPath.row] ;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)loadData{
    @WeakObj(self);
    [self Network_Post:@"getmyhomework" tag:Getmyhomework_Tag
                 param:@{@"pagesize":@(pagesize),
                         @"page":@(page),
                         @"isdone":@(0)}
               success:^(id result) {
                   [selfWeak.dataTable.mj_header endRefreshing];
                   [selfWeak.dataTable.mj_footer endRefreshing];
                   if ([result[@"code"]integerValue]==200) {
                       NSMutableArray *array = [NSMutableArray new];
                       for (NSDictionary *dic in result[DataKey][@"list"]) {
                           DDHomeworkModel *hModel = [DDHomeworkModel new];
                           hModel.homework_classid = dic[@"classid"];
                           hModel.homework_class_name = dic[@"class_name"];
                           hModel.homework_class_year = dic[@"class_year"];
                           hModel.homework_content = dic[@"content"];
                           hModel.homework_dateline = dic[@"dateline"];
                           hModel.homewrok_dohave = dic[@"dohave"];
                           hModel.homework_doneid = dic[@"doneid"];
                           hModel.homework_id = dic[@"id"];
                           hModel.homework_isdone = dic[@"isdone"];
                           hModel.homework_teacherid = dic[@"teacherid"];
                           hModel.homework_title = dic[@"title"];
                           hModel.homework_teacher_name = dic[@"teacher_name"];
                           [array addObject:hModel];
                       }
                       if (page == 1) {
                           selfWeak.dataArray = array;
                       }else
                       {
                           [selfWeak.dataArray addObjectsFromArray:array];
                       }
                       [selfWeak.dataTable reloadData];
                   }
               } failure:^(NSError *error) {
                   
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
