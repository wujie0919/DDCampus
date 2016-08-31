//
//  DDRoutineListController.m
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineListController.h"
#import "DDRoutineCell.h"
#import "DDRoutineWeekCell.h"
#import "DDClassweekpointModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
static NSString * const routineCell = @"routineCell";
static NSString * const weekCell = @"weekCell";
@interface DDRoutineListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic, assign) BOOL isdutyweekuser;
@property (nonatomic, assign) BOOL ismaster;

@end

@implementation DDRoutineListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dayArray = [NSMutableArray arrayWithCapacity:0];
    _weekArray = [NSMutableArray arrayWithCapacity:0];
    @WeakObj(self);
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfWeak loadData];
    }];
    
//    _dataTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [selfWeak loadData];
//    }];
    _dataTable.delegate = self;
    _dataTable.dataSource = self;
    [_dataTable registerNib:[UINib nibWithNibName:@"DDRoutineCell" bundle:nil] forCellReuseIdentifier:routineCell];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDRoutineWeekCell" bundle:nil] forCellReuseIdentifier:weekCell];
    _dataTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-160);
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    [_dataTable reloadData];
    if (index == 0) {
        if (_dayArray.count<=0) {
            [self loadData];
        }
       
    }
    else if(index == 1)
    {
        if (_weekArray.count<=0 ) {
            [self loadData];
        }
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _dayArray.count;
    if (_index == 1) {
        row = _weekArray.count;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        DDRoutineCell *cell = [tableView dequeueReusableCellWithIdentifier:routineCell];
        [cell.dayView setDayValue:_dayArray[indexPath.row]];
        cell.backgroundColor = RGB(237, 238, 239);
        if (_ismaster) {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    else
    {
        @WeakObj(self);
        DDRoutineWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:weekCell];
        [cell.weekView setWeekData:_weekArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(237, 238, 239);
        cell.weekView.handler = ^(){
            [selfWeak reload:indexPath];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index==0) {
        DDRoutineCell *hCell =(DDRoutineCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return hCell.dayView.height+10;
    }else
    {
        DDRoutineWeekCell *hCell =(DDRoutineWeekCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return hCell.weekView.height+10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_index==0) {
        if (_routineBlock && _ismaster) {
            _routineBlock(_dayArray[indexPath.row]);
        }
    }
}

- (void)reload:(NSIndexPath *)indexPath
{
    DDClassweekpointModel *model =_weekArray[indexPath.row];
    model.showAll = !model.showAll;
    [_weekArray replaceObjectAtIndex:indexPath.row withObject:model];
    [_dataTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

/**
 *  拉取数据
 */
- (void)loadData{
    
    @WeakObj(self);
    if (_index ==0) {
        //值日
        NSString *class_id = [USER_DEFAULT objectForKey:classid];
        [self Network_Post:@"getdutyday"
                       tag:Getdutyday_Tag
                     param:@{@"classid":class_id} success:^(id result) {
                         if ([result[@"code"]integerValue]==200) {
                             selfWeak.ismaster = [result[DataKey][@"ismaster"]boolValue];
                             NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                             [array addObjectsFromArray:result[DataKey][@"list"]];
                             selfWeak.dayArray = array;
                             [selfWeak.dataTable reloadData];
                         }
                         if ([result[@"code"]integerValue]==400) {
                             [selfWeak showErrorHUD:result[@"message"]];
                         }
                         [selfWeak.dataTable.mj_header endRefreshing];
                         [selfWeak.dataTable.mj_footer endRefreshing];
                     } failure:^(NSError *error) {
                         [selfWeak.dataTable.mj_header endRefreshing];
                         [selfWeak.dataTable.mj_footer endRefreshing];
                         [selfWeak showErrorHUD:@"网络异常"];
                     }];
    }
    else
    {
        [self Network_Post:@"getclassweekpoint"
                       tag:Getclassweekpoint_Tag
                     param:nil
                   success:^(id result) {
                       [selfWeak.dataTable.mj_header endRefreshing];
                       [selfWeak.dataTable.mj_footer endRefreshing];
                       if ([result[@"code"]integerValue]==200) {
                           selfWeak.isdutyweekuser = result[DataKey][@"isdutyweekuser"];
                           selfWeak.ismaster = result[DataKey][@"ismaster"];
                           NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                           for (NSDictionary *dic in result[DataKey][@"list"]) {
                               DDClassweekpointModel *model = [DDClassweekpointModel new];
                               model.classid = dic[@"classid"];
                               model.class_name = dic[@"class_name"];
                               model.class_year = dic[@"class_year"];
                               model.endday = dic[@"endday"];
                               model.points = dic[@"points"];
                               model.startday = dic[@"startday"];
                               model.weekname = dic[@"weekname"];
                               model.weekplanid = dic[@"weekplanid"];
                               model.cursort= dic[@"cursort"];
                               model.showAll = NO;
                               if ([dic[@"cut_subject"]isKindOfClass:[NSArray class]]) {
                                   model.cut_subject = dic[@"cut_subject"];
                               }
                               [array addObject:model];
                           }
                           _weekArray = array;
                           [selfWeak.dataTable reloadData];
                       }
                   } failure:^(NSError *error) {
                       [selfWeak.dataTable.mj_header endRefreshing];
                       [selfWeak.dataTable.mj_footer endRefreshing];
                       [selfWeak showErrorHUD:@"网络异常"];
                   }];
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
