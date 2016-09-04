//
//  DDEntryScoreController.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDEntryScoreController.h"
#import "DDEntryScoreViewCell.h"


static NSString * scorecell = @"scorecell";
@interface DDEntryScoreController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) NSMutableDictionary *socoreDic;
@end

@implementation DDEntryScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = _dict[@"student_name"];
    _dataTable.rowHeight = 54;
    [_dataTable registerNib:[UINib nibWithNibName:@"DDEntryScoreViewCell" bundle:nil] forCellReuseIdentifier:scorecell];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataTable.sectionFooterHeight = 60;
    _dataTable.sectionHeaderHeight = 40;
    _socoreDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([_dict[@"subject"]isKindOfClass:[NSArray class]]) {
        _array = _dict[@"subject"];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 40);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = RGB(101, 200, 126);
    [button addTarget:self action:@selector(editScore) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return  view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    lable.text = _headerTitle;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor whiteColor];
    return lable;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDEntryScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scorecell];
    [cell.entryView setCellData:_array[indexPath.row]];
    cell.entryView.valueText.tag = indexPath.row;
    @WeakObj(self);
    cell.entryView.scoreBlock = ^(NSString *value,NSInteger tag){
        [selfWeak.socoreDic setValue:value forKey:selfWeak.array[tag][@"scoreid"]];
    };
    return cell;
}

- (void)editScore
{
    [self showLoadHUD:@"提交中..."];
    if (_socoreDic.count < _array.count) {
        [self showErrorHUD:@"请输入完成的成绩"];
        return;
    }
    if (_array.count>0) {
        NSMutableArray *scoreIdArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *scoreArray = [NSMutableArray arrayWithCapacity:0];
        for (NSString *key in _socoreDic) {
            [scoreArray addObject:_socoreDic[key]];
            [scoreIdArray addObject:key];
        }
        [self showLoadHUD:@"提交中..."];
        @WeakObj(self);
        [self Network_Post:@"do_score" tag:Do_score_Tag
                     param:@{@"scorethemeid":_dataDic[@"id"],
                             @"scoreid":scoreIdArray,
                             @"score":scoreArray,
                             @"studentid":_dict[@"studentid"]}
                   success:^(id result) {
                       [selfWeak hideHUD];
                       if ([result[@"code"]integerValue]==200) {
                           
                           if (selfWeak.dataArray.count>0) {
                               [selfWeak.dataArray removeObjectAtIndex:0];
                               if (selfWeak.dataArray.count>0) {
                                   selfWeak.dict = _dataArray[0];
                                   selfWeak.array = _dataArray[0][@"subject"];
                                   [selfWeak.dataTable reloadData];
                               }
                           }
                           else
                           {
                               [selfWeak.navigationController popViewControllerAnimated:YES];
                           }
                       }
                       else
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
