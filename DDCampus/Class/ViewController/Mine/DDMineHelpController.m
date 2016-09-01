//
//  DDMineHelpController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMineHelpController.h"
#import "DDMineHelpCell.h"

@interface DDMineHelpController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *array;
@end

@implementation DDMineHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的帮助";
    [self setBackBarButtonItem];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDMineHelpCell" bundle:nil] forCellReuseIdentifier:@"help"];
    @WeakObj(self);
    [self Network_Post:@"gethelplist" tag:Gethelplist_Tag param:nil success:^(id result) {
        if ([result[@"code"]integerValue]==200) {
            selfWeak.array = result[DataKey];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMineHelpCell *cell = (DDMineHelpCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.helpView.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMineHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"help"];
    [cell.helpView setData:_array[indexPath.row]];
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
