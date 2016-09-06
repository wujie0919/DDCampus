//
//  DDHomeWorkDetailsController.m
//  DDCampus
//
//  Created by wu on 16/8/16.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeWorkDetailsController.h"
#import "DDHomeworkModel.h"
#import "DDHomeWorkDetailsCell.h"
#import "DDHomeworkDetailsModel.h"
#import "DDNoSubmitInfoCell.h"
#import "DDSubmitInfoCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString * const detailsCell = @"detailsCell";
static NSString * const UnSubmitInfoCell = @"UnSubmitInfoCell";
static NSString * const SubmitInfoCell =@"SubmitInfoCell";

@interface DDHomeWorkDetailsController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailsTable;
@property (nonatomic, strong) DDHomeworkDetailsModel *detailsModel;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger type ;
@property (nonatomic, strong) DDButton *button;
@property (nonatomic, assign) BOOL hasDone;
@property (nonatomic, assign) BOOL hasNoDone;
@property (nonatomic, copy) NSDictionary *phoneDic;
@end

@implementation DDHomeWorkDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _type = [appDelegate.userModel.type integerValue];
    _phoneDic = [NSDictionary dictionary];
    @WeakObj(self);
    if (_type==1 || _type ==2) {
        self.title = @"作业详情";
        _detailsModel = [DDHomeworkDetailsModel new];
        
        [self showLoadHUD:@"加载中..."];
        [self Network_Post:@"gethomeworkdetail" tag:Gethomeworkdetail_Tag
                     param:@{@"homeworkid":_homeworkModel.homework_id} success:^(id result) {
                         [selfWeak hideHUD];
                         if ([result[@"code"]integerValue]==200) {
                             NSDictionary *dic = result[DataKey][@"homeworkdata"];
                             selfWeak.detailsModel.homework_id = dic[@"id"];
                             selfWeak.detailsModel.classid = dic[@"classid"];
                             selfWeak.detailsModel.teacherid = dic[@"teacherid"];
                             selfWeak.detailsModel.title = dic[@"title"];
                             selfWeak.detailsModel.content =dic[@"content"];
                             selfWeak.detailsModel.dohave = dic[@"dohave"];
                             selfWeak.detailsModel.dateline = dic[@"dateline"];
                             selfWeak.detailsModel.updateline = dic[@"updateline"];
                             selfWeak.detailsModel.class_year = dic[@"class_year"];
                             selfWeak.detailsModel.class_name = dic[@"class_name"];
                             selfWeak.detailsModel.teacher_name = dic[@"teacher_name"];
                             selfWeak.detailsModel.donedata = dic[@"donedata"];
                             [selfWeak.detailsTable reloadData];
                             if ([selfWeak.detailsModel.dohave integerValue]==1 && selfWeak.type ==2) {
                                 [selfWeak.detailsTable mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 50, 0));
                                 }];
                                 selfWeak.button.hidden = NO;
                                 [selfWeak.button mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.top.equalTo(selfWeak.detailsTable.mas_bottom).offset(0);
                                     make.left.equalTo(selfWeak.view).offset(10);
                                     make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 44));
                                 }];
                             }
                         }else
                         {
                             [selfWeak showErrorHUD:@"获取失败"];
                         }
                     } failure:^(NSError *error) {
                         [selfWeak hideHUD];
                         [selfWeak showErrorHUD:@"网络异常"];
                     }];
    }
    else
    {
        _array = [NSMutableArray arrayWithCapacity:0];
        [_detailsTable registerNib:[UINib nibWithNibName:@"DDSubmitInfoCell" bundle:nil] forCellReuseIdentifier:SubmitInfoCell];
        [_detailsTable registerNib:[UINib nibWithNibName:@"DDNoSubmitInfoCell" bundle:nil] forCellReuseIdentifier:UnSubmitInfoCell];
        self.title = @"完成情况";
        [self showLoadHUD:@"加载中..."];
        [self Network_Post:@"gethomeworkdone"
                       tag:Gethomeworkdone_Tag
                     param:@{@"homeworkid":_homeworkModel.homework_id} success:^(id result) {
                         [selfWeak hideHUD];
                         if ([result[@"code"] integerValue]==200) {
                             DDHomeworkDetailsModel *infoModel = [DDHomeworkDetailsModel new];
                             NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                             NSDictionary *dic = result[DataKey][@"homeworkdata"];
                             infoModel.homework_id = dic[@"id"];
                             infoModel.classid = dic[@"classid"];
                             infoModel.teacherid = dic[@"teacherid"];
                             infoModel.title = dic[@"title"];
                             infoModel.content =dic[@"content"];
                             infoModel.dohave = dic[@"dohave"];
                             infoModel.dateline = dic[@"dateline"];
                             infoModel.updateline = dic[@"updateline"];
                             infoModel.class_year = dic[@"class_year"];
                             infoModel.class_name = dic[@"class_name"];
                             infoModel.teacher_name = dic[@"teacher_name"];
                             [data addObject:infoModel];
                             
                             if ([result[DataKey][@"list"] isKindOfClass:[NSDictionary class]]) {
                                 NSDictionary *listDic = result[DataKey][@"list"];
                                 if (listDic[@"nodone"]) {
                                     selfWeak.hasNoDone = YES;
                                     [data addObject:listDic[@"nodone"]];
                                 }
                                 if (listDic[@"done"]) {
                                     selfWeak.hasDone = YES;
                                     [data addObject:listDic[@"done"]];
                                 }
                                 
                             }
                             selfWeak.array = data;
                             [selfWeak.detailsTable reloadData];
                         }else
                         {
                             [selfWeak showErrorHUD:@"获取失败"];
                         }
                     } failure:^(NSError *error) {
                         [selfWeak hideHUD];
                         [selfWeak showErrorHUD:@"网络异常"];
                     }];
    }
    
    [_detailsTable registerNib:[UINib nibWithNibName:@"DDHomeWorkDetailsCell" bundle:nil] forCellReuseIdentifier:detailsCell];
    _detailsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_detailsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    if (_type==2) {
        _button = [DDButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 44);
        _button.hidden = YES;
        [_button setTitle:@"提交" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button addTarget:selfWeak action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == 1|| _type ==2) {
        return 1;
    }
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == 1|| _type ==2) {
        DDHomeWorkDetailsCell *cell = (DDHomeWorkDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.height+10;
    }
    else
    {
        if (indexPath.row ==0) {
            DDHomeWorkDetailsCell *cell = (DDHomeWorkDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            
            return cell.height+10;
            return [tableView fd_heightForCellWithIdentifier:detailsCell cacheByIndexPath:indexPath configuration:^(DDHomeWorkDetailsCell *cell) {
                
                // 在这个block中，重新cell配置数据源
                [cell setDetailsValue:_array[0]];
            }];

        }
        if (indexPath.row ==1) {
            if (_hasDone && !_hasNoDone) {
                DDSubmitInfoCell *cell = (DDSubmitInfoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                return cell.submitInfoView.height+10;
            }else{
                DDNoSubmitInfoCell *cell = (DDNoSubmitInfoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                return cell.unSbumitView.height+10;
            }
        }
        if (indexPath.row==2) {
            DDSubmitInfoCell *cell = (DDSubmitInfoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.submitInfoView.height+10;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == 1 || _type ==2) {
        DDHomeWorkDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailsCell];
        [cell setDetailsValue:_detailsModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        if (indexPath.row==0) {
            DDHomeWorkDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:detailsCell];
            [cell setDetailsValue:_array[0]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            if (_hasDone && !_hasNoDone) {
                DDSubmitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitInfoCell];
                [cell.submitInfoView setArray:_array[1]];
                cell.backgroundColor = RGB(237, 238, 239);
                return cell;
            }
            else{
                DDNoSubmitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:UnSubmitInfoCell];
                [cell.unSbumitView setArray:_array[1]];
                @WeakObj(self);
                cell.unSbumitView.callBlock = ^(NSDictionary *dic){
                    [selfWeak callPhone:dic];
                };
                cell.backgroundColor = RGB(237, 238, 239);
                return cell;
            }
        }
        
        if (indexPath.row ==2) {
            DDSubmitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitInfoCell];
            [cell.submitInfoView setArray:_array[2]];
            cell.backgroundColor = RGB(237, 238, 239);
            return cell;
        }
    }
    return nil;
}

- (void)callPhone:(NSDictionary *)phone
{
    _phoneDic = phone;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"您确定要联系%@同学吗？",phone[@"name"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phoneDic[@"mobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)submit:(UIButton *)button
{
    if ([_detailsModel.donedata[@"id"] isValidString]) {
        @WeakObj(self);
        [self showLoadHUD:@"提交中..."];
        [self Network_Post:@"do_homeworkdone"
                       tag:Do_homeworkdone_Tag
                     param:@{@"doneid":_detailsModel.donedata[@"id"]} success:^(id result) {
                         [selfWeak hideHUD];
                         if ([result[@"code"]integerValue]==200) {
                             [selfWeak showSuccessHUD:@"提交成功"];
                             selfWeak.button.hidden = YES;
                             [selfWeak.detailsTable mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                             }];
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
