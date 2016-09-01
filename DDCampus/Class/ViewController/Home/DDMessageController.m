//
//  DDMessageController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMessageController.h"
#import "DDMessageCell.h"

static NSString * const msgCell = @"msgCell";
@interface DDMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DDMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"站内消息";
    [self setBackBarButtonItem];
    
    [_dataTable registerNib:[UINib nibWithNibName:@"DDMessageCell" bundle:nil] forCellReuseIdentifier:msgCell];
    [self getData];
    @WeakObj(self);
    _dataTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 1;
        [selfWeak getData];
    }];
    
    _dataTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        selfWeak.page++;
        [selfWeak getData];
    }];

}

- (void)getData
{
    @WeakObj(self);
    [self Network_Post:@"getnotice" tag:Getnotice_Tag param:@{@"page":@(_page)} success:^(id result) {
        [selfWeak.dataTable.mj_header endRefreshing];
        [selfWeak.dataTable.mj_footer endRefreshing];
        if ([result[@"code"]integerValue]==200) {
            
            NSMutableArray *dataArray = [NSMutableArray new];
            if ([result[DataKey][@"list"]isKindOfClass:[NSArray class]]) {
                [dataArray addObjectsFromArray:result[DataKey][@"list"]];
            }
            if (selfWeak.page == 1) {
                selfWeak.array = dataArray;
            }else{
                [selfWeak.array addObjectsFromArray:dataArray];
            }
            
            [selfWeak.dataTable reloadData];
        }
        else
        {
            [selfWeak showErrorHUD:result[@"message"]];
        }
    } failure:^(NSError *error) {
        [selfWeak showErrorHUD:@"网络异常"];
        [selfWeak.dataTable.mj_header endRefreshing];
        [selfWeak.dataTable.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMessageCell *cell = (DDMessageCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.msgView.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:msgCell];
    [cell.msgView setData:_array[indexPath.row]];
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
