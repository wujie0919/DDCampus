//
//  DDSelectClssController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSelectClssController.h"
#import "DDSelectClassInfoCell.h"
#import "DDRoutineSelectStudentModel.h"
#import "DDScoreInfoController.h"

static NSString * const infoCell = @"infoCell";
@interface DDSelectClssController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;

@end

@implementation DDSelectClssController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择班级";
    [self setBackBarButtonItem];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDSelectClassInfoCell" bundle:nil] forCellReuseIdentifier:infoCell];
    _dataTable.rowHeight = 80;
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegate.classArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDSelectClassInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
    DDRoutineSelectStudentModel *model = appDelegate.classArray[indexPath.row];
    [cell.selectView setTitle:model.name forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @WeakObj(self);
    cell.sBlock = ^(){
        [selfWeak next:indexPath.row];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (void)next:(NSInteger)row
{
    DDScoreInfoController *infoVC = [[DDScoreInfoController alloc]initWithNibName:@"DDScoreInfoController" bundle:nil];
    infoVC.model = appDelegate.classArray[row];
    
    [self.navigationController pushViewController:infoVC animated:YES];
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
