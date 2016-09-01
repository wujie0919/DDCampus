//
//  DDRoutinePlanController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinePlanController.h"
#import "DDRoutinePlanCell.h"

static NSString * const plancell = @"plancell";

@interface DDRoutinePlanController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DDRoutinePlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"值周安排表";
    [self setBackBarButtonItem];
    
    @WeakObj(self);
    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDRoutinePlanCell" bundle:nil] forCellReuseIdentifier:plancell];
    [self showLoadHUD:@"加载中..."];
    [self Network_Post:@"getdutyweek" tag:Getdutyweek_Tag param:nil success:^(id result) {
        [selfWeak hideHUD];
        if ([result[@"code"]integerValue]==200) {
            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
            if ([result[DataKey][@"list"]isKindOfClass:[NSArray class]]) {
                [dataArray addObjectsFromArray:result[DataKey][@"list"]];
            }
            selfWeak.array = dataArray;
            [selfWeak.dataTable reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
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
    DDRoutinePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:plancell];
    [cell.planView setData:_array[indexPath.row]];
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
