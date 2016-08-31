//
//  DDRoutineRanController.m
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineRanController.h"
#import "DDRankHeaderView.h"
#import "DDRankCell.h"

static NSString * const rankCell = @"rankCell";

@interface DDRoutineRanController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *rankTable;
@property (nonatomic, copy) NSArray *headerArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DDRoutineRanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"值周排名";
    // Do any additional setup after loading the view from its nib.
    DDRankHeaderView *rankView = [[[NSBundle mainBundle] loadNibNamed:@"DDRankHeaderView" owner:nil options:nil] lastObject];
    [rankView setHeaderValue:@[@"班级",@"分数",@"名次"]];
    _rankTable.tableHeaderView = rankView;
    _rankTable.sectionHeaderHeight = 50;
    _rankTable.rowHeight = 50;
    
    [_rankTable registerNib:[UINib nibWithNibName:@"DDRankCell" bundle:nil] forCellReuseIdentifier:rankCell];
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
    DDRankCell *cell = [tableView dequeueReusableCellWithIdentifier:rankCell];
    return cell;
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
