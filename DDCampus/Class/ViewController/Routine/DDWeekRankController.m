//
//  DDWeekRankController.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDWeekRankController.h"
#import "DDWeekRankingCell.h"

static NSString * const rankCell = @"rankCell";

@interface DDWeekRankController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DDWeekRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"值周排名";
    [self setBackBarButtonItem];
    
    _dataArray = [NSMutableArray new];
//    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//    CGFloat widht = (SCREEN_WIDTH-90)/array.count;
//    for (int i=0;i<array.count;i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*widht+((i+1)*30), 0, widht, 44)];
//        label.text = array[i];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:14];
//        [_headerView addSubview:label];
//    }
//    _dataTable.tableHeaderView = _headerView;
//    _dataTable.sectionHeaderHeight = 44;
    _dataTable.rowHeight = 44;
    [_dataTable registerNib:[UINib nibWithNibName:@"DDWeekRankingCell" bundle:nil] forCellReuseIdentifier:rankCell];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDWeekRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:rankCell];
    [cell.rankView setCellData:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)loadData
{
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"getgradeweekpoint" tag:Getgradeweekpoint_Tag param:@{@"weekplanid":_weekplanid} success:^(id result) {
        [selfWeak hideHUD];
        if ([result[@"code"]integerValue]==200) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            if ([result[DataKey][@"sortlist"] isKindOfClass:[NSArray class]]) {
                [array addObjectsFromArray:result[DataKey][@"sortlist"]];
            }
            NSArray *tarray = @[@"班级",@"分数",@"名次"];
            [array insertObject:tarray atIndex:0];
            selfWeak.dataArray = array;
            [selfWeak.dataTable reloadData];
        }
        else{
            [selfWeak showErrorHUD:result[@"message"]];
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
