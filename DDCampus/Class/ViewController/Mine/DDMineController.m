//
//  DDMineController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDMineController.h"
#import "DDMineViewCell.h"
#import "DDMineAvatarViewCell.h"
#import "DDAdviseViewController.h"
#import "DDEditPassController.h"
#import "DDSetMineInfoController.h"

static NSString * const mineCell = @"mineCell";
static NSString * const headerCell = @"header";

@interface DDMineController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *mineTable;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *imageArray;
@end

@implementation DDMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人中心";
    [_mineTable registerNib:[UINib nibWithNibName:@"DDMineViewCell" bundle:nil] forCellReuseIdentifier:mineCell];
    [_mineTable registerNib:[UINib nibWithNibName:@"DDMineAvatarViewCell" bundle:nil] forCellReuseIdentifier:headerCell];
    _titleArray = @[@"修改密码",@"服务协议",@"我的帮助"];
    _imageArray = @[[UIImage imageNamed:@"setup"],[UIImage imageNamed:@"agreement"],[UIImage imageNamed:@"help"]];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mineTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section == 2) {
        row = 3;
    }
    if(section ==5)
    {
        row = 0;
    }
    return  row;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = RGB(234, 233, 220);
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    return  headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (indexPath.section == 0) {
        height = 90;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 10;
    if (section == 0) {
        height = 0;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMineViewCell *mCell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    mCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSInteger section = indexPath.section;
    if (section == 0) {
        DDMineAvatarViewCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:headerCell];
        avatarCell.nicknameLabel.text = appDelegate.userModel.nickname;
        [avatarCell.avatarImageView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,appDelegate.userModel.pic] placeholder:nil];
        return avatarCell;
    }
    if (section == 1) {
        mCell.iconImage.image = [UIImage imageNamed:@"community2"];
        mCell.title.text = @"我的社区";
    }
    
    if (section == 2) {
        mCell.iconImage.image = _imageArray[indexPath.row];
        mCell.title.text =_titleArray[indexPath.row];
    }
    
    if (section == 3) {
        mCell.iconImage.image = [UIImage imageNamed:@"feedback"];
        mCell.title.text = @"反馈建议";
    }
    if (section == 4) {
        mCell.iconImage.image = [UIImage imageNamed:@"logout_icon"];
        mCell.title.text = @"退出登录";
    }
    return mCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if (section == 0) {
        DDSetMineInfoController *setMineController = [[DDSetMineInfoController alloc]initWithNibName:@"DDSetMineInfoController" bundle:nil];
        [self.navigationController pushViewController:setMineController animated:YES];
    }
    if (section == 3) {
        DDAdviseViewController *adviseController = [[DDAdviseViewController alloc]initWithNibName:@"DDAdviseViewController" bundle:nil];
        [self.navigationController pushViewController:adviseController animated:YES];
    }
    
    if (section == 2) {
        NSInteger row = indexPath.row;
        if (row == 0) {
            DDEditPassController *editPassController = [[DDEditPassController alloc]initWithNibName:@"DDEditPassController" bundle:nil];
            [self.navigationController pushViewController:editPassController animated:YES];
        }
    }
    if (section==4) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self Network_Post:@"logout" tag:Logout_Tag param:nil success:^(id result) {
            if ([result[@"code"]integerValue]==200) {
                [appDelegate showLogin];
            }
        } failure:^(NSError *error) {
            
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
