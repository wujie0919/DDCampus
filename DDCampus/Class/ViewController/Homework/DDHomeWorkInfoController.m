//
//  DDHomeWorkInfoController.m
//  DDCampus
//
//  Created by wu on 16/8/25.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeWorkInfoController.h"
#import "DDHomeworkCell.h"
#import "DDHomeWorkDetailsController.h"

static NSString * const homeworkCell = @"homeworkCell";
static NSInteger const pagesize = 5;

@interface DDHomeWorkInfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger all_page;
    NSInteger yi_page;
    NSInteger wei_page;
}
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *yiArray;
@property (nonatomic, strong) NSMutableArray *weiArray;
@end

@implementation DDHomeWorkInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataTable.delegate = self;
    _dataTable.dataSource = self;
    _dataArray = [NSMutableArray new];
    _yiArray = [NSMutableArray new];
    _weiArray = [NSMutableArray new];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDHomeworkCell" bundle:nil] forCellReuseIdentifier:homeworkCell];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-160);
    @WeakObj(self);
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (selfWeak.index == 0) {
            all_page = 1;
        }else if (selfWeak.index==1)
        {
            yi_page = 1;
        }else
        {
            wei_page = 1;
        }
        [selfWeak loadData];
    }];
    
    _dataTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (selfWeak.index == 0) {
            all_page++;
        }else if (selfWeak.index==1)
        {
            yi_page++;
        }else
        {
            wei_page++;
        }
        [selfWeak loadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    [self.dataTable reloadData];
    if (index == 0) {
        if (_dataArray.count<=0) {
            [self loadData];
        }

    }
    else if(index == 1)
    {
        if (_yiArray.count<=0 ) {
            [self loadData];
        }

    }
    else
    {
        if (_weiArray.count<=0) {
            [self loadData];
        }
    }
}

- (void)loadData{
    NSInteger page = 1;
    switch (_index) {
        case 0:
            page = all_page;
            break;
        case 1:
            page = yi_page;
            break;
        case 2:
            page = wei_page;
            break;
        default:
            break;
    }
    @WeakObj(self);
    [self Network_Post:@"getmyhomework" tag:Getmyhomework_Tag
                 param:@{@"pagesize":@(pagesize),
                         @"page":@(page),
                         @"isdone":@(_index)}
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
                       if (selfWeak.index ==0) {
                           if (page == 1) {
                               selfWeak.dataArray = array;
                           }else
                           {
                               [selfWeak.dataArray addObjectsFromArray:array];
                           }
                       }
                       if (selfWeak.index ==1) {
                           if (page == 1) {
                               selfWeak.yiArray = array;
                           }else
                           {
                               [selfWeak.yiArray addObjectsFromArray:array];
                           }
                       }
                       if (selfWeak.index ==2) {
                           if (page == 1) {
                               selfWeak.weiArray = array;
                           }else
                           {
                               [selfWeak.weiArray addObjectsFromArray:array];
                           }
                       }
                       [selfWeak.dataTable reloadData];
                   }
               } failure:^(NSError *error) {
                   
               }];
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _dataArray.count;
    if (_index==1) {
        row = _yiArray.count;
    }
    if (_index == 2) {
        row = _weiArray.count;
    }
    return row;
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
    if (_index==0) {
        [cell setData:_dataArray[row] row:row];
    }else if (_index == 1)
    {
        [cell setData:_yiArray[row] row:row];
    }else{
        [cell setData:_weiArray[row] row:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_tbsBlock) {
        DDHomeworkModel *model = [DDHomeworkModel new];
        NSInteger row = indexPath.row;
        if (_index==0) {
            model=_dataArray[row];
        }else if (_index == 1)
        {
            model = _yiArray[row];
        }else{
            model = _weiArray[row];
        }
        _tbsBlock(model);
    }
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
