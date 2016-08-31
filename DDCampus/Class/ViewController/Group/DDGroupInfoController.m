//
//  DDGroupInfoController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupInfoController.h"
#import "DDGrounpNoticeController.h"
#import "DDGroupInfoViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DDGroupInfoUserCell.h"
#import "DDGroupMemberController.h"
#import "DDGroupInfoNormalCell.h"
#import "DDSetGroupManagerController.h"
#import "DDGroupInfoFooterView.h"

@interface DDGroupInfoController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) NSInteger tsection;
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) DDGroupInfoFooterView *footerView;
@end
static NSString * const infoCell = @"infocell";
static NSString * const normalCell = @"normalCell";
static NSString * const usercell = @"userCell";

@implementation DDGroupInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tsection = 0;
    _array = @[@"转让群主",@"删除群成员",@"管理员设置"];
    if (!_rightButton) {
        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.backgroundColor = RGB(48, 185, 113);
        _rightButton.frame = CGRectMake(0, 5, 100, 30);
        _rightButton.layer.cornerRadius= 5;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 1;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    }
    [_rightButton addTarget:self action:@selector(sendNotice) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"发布群通知" forState:UIControlStateNormal];
    [self setBackBarButtonItem];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupInfoNormalCell" bundle:nil] forCellReuseIdentifier:normalCell];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupInfoViewCell" bundle:nil] forCellReuseIdentifier:infoCell];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDGroupInfoUserCell" bundle:nil] forCellReuseIdentifier:usercell];
    _dataTable.sectionFooterHeight = 100;
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"DDGroupInfoFooterView" owner:nil options:nil] lastObject];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        _footerView.mBlock = ^(){
            
        };
        [_footerView.exitButton addTarget:self action:@selector(exitGroup) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.title = @"群组资料";
    [self getData];
}
- (void)sendNotice
{
    DDGrounpNoticeController *noticeVC=[[DDGrounpNoticeController alloc]initWithNibName:@"DDGrounpNoticeController" bundle:nil];
    noticeVC.groupId = _groupDic[@"groupid"];
    [self.navigationController pushViewController:noticeVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tsection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (_tsection==3) {
        if (section==0) {
            row = 1;
        }
        if (section == 1) {
            row = 2;
        }
        if (section == 2) {
            row = 3;
        }
    }else{
        if (section==0) {
            row = 1;
        }
        if (section == 1) {
            row = 2;
        }
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = 88;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:infoCell cacheByIndexPath:indexPath configuration:^(DDGroupInfoViewCell *cell) {
                
                // 在这个block中，重新cell配置数据源
                NSString *value = _dic[@"message"];
                if (![value isValidString]) {
                    value = @"空";
                }
                [cell setInfo:value];
            }]+10;
        }
        if (indexPath.row == 1) {
            return 100;
        }
    }
    if (indexPath.section == 2) {
        height = 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section != 0) {
        height = 10;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section ==0) {
        DDGroupInfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell];
        cell.valueLabel.text = _dic[@"title"];
        return cell;
    }
    else if (section == 1) {
        if (row == 0) {
            DDGroupInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
            NSString *value = _dic[@"message"];
            if (![value isValidString]) {
                value = @"空";
            }
            [cell setInfo:value];
            return cell;
        }
        if (row == 1) {
            DDGroupInfoUserCell *cell = [tableView dequeueReusableCellWithIdentifier:usercell];
            [cell setInfo:_dic];
            if ([_dic[@"identity"]integerValue]==1){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }
    }
    else
    {
        DDGroupInfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell];
        cell.valueLabel.text = _array[row];
        cell.valueLabel.font = [UIFont systemFontOfSize:14];
        if ([_dic[@"identity"]integerValue]==1){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if ([_dic[@"identity"]integerValue]==1) {
        if ((section == 1 && row == 1) || (section == 2 && row == 1)) {
            DDGroupMemberController *member = [[DDGroupMemberController alloc]initWithNibName:@"DDGroupMemberController" bundle:nil];
            if (section==1) {
                member.title = @"群成员";
            }else
                member.title = @"删除群成员";
            [member setData:_dic group:_groupDic];
            [self.navigationController pushViewController:member animated:YES];
        }
        if (section == 2 && row == 2) {
            DDSetGroupManagerController *managerVC=[[DDSetGroupManagerController alloc]initWithNibName:@"DDSetGroupManagerController" bundle:nil];
            [managerVC setData:_dic group:_groupDic];
            [self.navigationController pushViewController:managerVC animated:YES];
        }
    }
}

- (void)getData
{
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"getgroupdata" tag:Getgroupdata_Tag
                 param:@{@"groupid":_groupDic[@"groupid"]}
               success:^(id result) {
                   [selfWeak hideHUD];
                   if ([result[@"code"]integerValue]==200) {
                       selfWeak.dic = result[DataKey];
                       if ([result[DataKey][@"identity"]integerValue]==1) {
                           selfWeak.tsection = 3;
                       }else
                       {
                           selfWeak.tsection = 2;
                       }
                       [selfWeak.dataTable reloadData];
                       selfWeak.dataTable.tableFooterView = selfWeak.footerView;
                   }
               } failure:^(NSError *error) {
                   
               }];
}

- (void)exitGroup
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定退出该群组？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self showLoadHUD:@"退出中..."];
        @WeakObj(self);
        [self Network_Post:@"do_grouplogout" tag:Do_grouplogout_Tag
                     param:@{@"groupid":_groupDic[@"groupid"]} success:^(id result) {
                         [selfWeak hideHUD];
                         if ([result[@"code"]integerValue]==200) {
                             [selfWeak showSuccessHUD:@"退出成功"];
                             if (selfWeak.exitBlock) {
                                 selfWeak.exitBlock();
                             }
                             [selfWeak.navigationController popViewControllerAnimated:YES];
                             
                         }else
                         {
                             [selfWeak showErrorHUD:result[@"message"]];
                         }
                     } failure:^(NSError *error) {
                         [selfWeak hideHUD];
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
