//
//  DDCurveViewController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCurveViewController.h"
#import "MPGraphView.h"
#import "MPPlot.h"
#import "MPBarsGraphView.h"
#import "DDSubjeCtureCell.h"

static NSString * const subcell = @"subcell";

@interface DDCurveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MPGraphView *graph;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *scorethemeid;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DDCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = [NSString stringWithFormat:@"%@成绩", _dic[@"name"]];
    _graph = [[MPGraphView alloc] initWithFrame:CGRectMake(10,45, SCREEN_WIDTH-20, 150)];
    
    _graph.fillColors = @[RGB(101, 200, 126),RGB(215, 241, 230)];
    _graph.graphColor = RGB(101, 200, 126);
    _graph.curved = NO;
    [self.view addSubview:_graph];
    
    @WeakObj(self);
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(10);
        make.left.equalTo(selfWeak.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    [_allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(10);
        make.right.equalTo(selfWeak.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    _allButton.layer.cornerRadius = 4;
    _allButton.layer.masksToBounds = YES;
    _allButton.backgroundColor =RGB(101, 200, 126);
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.view).offset(44);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    [_graph mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.lineLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.view).offset(10);
        make.right.equalTo(selfWeak.view).offset(-10);
        make.height.mas_equalTo(150);
    }];
    
    [_avgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.graph.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [_paimingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.graph.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.avgLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [_zongheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.graph.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.paimingLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.avgLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak.view).offset(0);
        make.bottom.equalTo(selfWeak.view).offset(0);
        make.right.equalTo(selfWeak.view).offset(0);
    }];
    _type = [appDelegate.userModel.type integerValue];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDSubjeCtureCell" bundle:nil] forCellReuseIdentifier:subcell];
    _scorethemeid = @"";
    [self loadData];
    if (_type == 3) {
        _allButton.hidden = NO;
    }
    else
    {
        _allButton.hidden = YES;
    }
}

- (void)loadData
{
    if (_type != 3 ) {
        @WeakObj(self);
        if ([_scorethemeid isValidString]) {
            [self showLoadHUD:@"加载中..."];
        }
        [self Network_Post:@"getsubjecttrend" tag:Getsubjecttrend_Tag
                     param:@{@"subjectid":_dic[@"subjectid"],
                             @"scorethemeid":_scorethemeid}
                   success:^(id result) {
                       [selfWeak hideHUD];
                       if ([result[@"code"]integerValue]==200) {
                           if ([result[DataKey]isKindOfClass:[NSDictionary class]]) {
                               [selfWeak setData:result[DataKey]];
                           }
                       }
                   } failure:^(NSError *error) {
                       [selfWeak hideHUD];
                   }];
    }
    else
    {
        
    }
}

- (void)setData:(NSDictionary *)data{
    _array = [NSMutableArray new];
    if ([data[@"banner"]isKindOfClass:[NSDictionary class]]) {
        _avgLabel.text = [NSString stringWithFormat:@"平均分：%@",data[@"banner"][@"avg"]];
        _paimingLabel.text = [NSString stringWithFormat:@"当前排名：%@",data[@"banner"][@"sort"]];
        _zongheLabel.text = [NSString stringWithFormat:@"综合排名：%@",data[@"banner"][@"cursort"]];

    }
    self.title = [NSString stringWithFormat:@"%@成绩", data[@"subjectname"]];
    NSMutableArray *dataArray = [NSMutableArray array];
    if ([data[@"themelist"] isKindOfClass:[NSArray class]]) {
        [_array addObjectsFromArray:data[@"themelist"]];
        for (NSDictionary *dict in data[@"themelist"]) {
             NSString *score = dict[@"score"];
            [dataArray addObject:@([score integerValue])];
        }
    }
    _graph.values = dataArray;
    [_dataTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDSubjeCtureCell *cell = [tableView dequeueReusableCellWithIdentifier:subcell];
    NSDictionary *subDic = _array[indexPath.row];
    cell.nameLabel.text = subDic[@"name"];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@ 分",subDic[@"score"]];
    cell.dateLabel.text = subDic[@"examtime"];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = RGB(101, 200, 126);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *subDic = _array[indexPath.row];
    _scorethemeid = subDic[@"scorethemeid"];
    [self loadData];
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
