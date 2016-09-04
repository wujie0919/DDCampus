//
//  DDEditMaxScoreController.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDEditMaxScoreController.h"
#import "DDEditMaxScoreCell.h"
#import "DDRoutineSelectStudentModel.h"

static NSString * maxScorecell = @"maxScorecell";

@interface DDEditMaxScoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (nonatomic, strong) NSMutableDictionary *scoreDic;
@end

@implementation DDEditMaxScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_dataTable registerNib:[UINib nibWithNibName:@"DDEditMaxScoreCell" bundle:nil] forCellReuseIdentifier:maxScorecell];
    _dataTable.rowHeight = 54;
    self.title = @"学科成绩录入";
    [self setBackBarButtonItem];
    _scoreDic = [NSMutableDictionary dictionary];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    rightButton.backgroundColor = RGB(48, 185, 113);
    rightButton.frame = CGRectMake(0, 5, 60, 30);
    rightButton.layer.cornerRadius= 5;
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
    rightButton.layer.borderWidth = 1;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(saveScore) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
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
    DDEditMaxScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:maxScorecell];
    DDRoutineSelectStudentModel *model = _array[indexPath.row];
    cell.maxView.nameLabel.text = model.name;
    cell.maxView.scoreText.tag = indexPath.row;
    @WeakObj(self);
    cell.maxView.changeBlock = ^(NSString *value,NSInteger viewTag){
        [selfWeak.scoreDic setValue:value forKey:@(viewTag).stringValue];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)saveScore
{
    [self.view endEditing:YES];
    if (_scoreDic.count<_array.count) {
        [self showErrorHUD:@"请输入全部成绩"];
        return;
    }
    if (_editBlock) {
        _editBlock(_scoreDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSeddgue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
