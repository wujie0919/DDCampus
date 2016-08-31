//
//  DDSetMineInfoController.m
//  DDCampus
//
//  Created by wu on 16/8/10.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSetMineInfoController.h"
#import "DDSetAvatarCell.h"
#import "DDSetAnthorCell.h"
#import "DDSetValueController.h"

static NSString * const avatarCell = @"avatarCell";
static NSString * const valueCell = @"valueCell";

@interface DDSetMineInfoController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *valueTable;
@end

@implementation DDSetMineInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_valueTable registerNib:[UINib nibWithNibName:@"DDSetAvatarCell" bundle:nil] forCellReuseIdentifier:avatarCell];
    [_valueTable registerNib:[UINib nibWithNibName:@"DDSetAnthorCell" bundle:nil] forCellReuseIdentifier:valueCell];
    [self setBackBarButtonItem];
    self.title = @"资料修改";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
    if (indexPath.section == 1) {
        height = 50;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 1) {
        height = 10;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section  == 1) {
        row = 2;
    }
    return row;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = RGB(234, 233, 220);
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    return  headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DDSetAvatarCell *aCell = [tableView dequeueReusableCellWithIdentifier:avatarCell];
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return aCell;
    }
    else
    {
        DDSetAnthorCell *anCell = [tableView dequeueReusableCellWithIdentifier:valueCell];
        if (indexPath.row == 0) {
            anCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return anCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DDSetValueController *valueController = [[DDSetValueController alloc]initWithNibName:@"DDSetValueController" bundle:nil];
            [self.navigationController pushViewController:valueController animated:YES];
        }
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        [actionSheet showInView:self.view];
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
