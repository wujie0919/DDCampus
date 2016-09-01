//
//  DDCommunityHeaderView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityHeaderView.h"
#import "URTableView.h"
#import "DDCommunityHeaderCell.h"


static NSString * const headerCell = @"headerCell";
@interface DDCommunityHeaderView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) URTableView *table;
@property (nonatomic, copy) GroupSelectBlock block;
@end

@implementation DDCommunityHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)headerView:(CGRect)frame selectBlock:(GroupSelectBlock)selectBlock
{
    return [[self alloc]initWithFrame:frame selectBlock:selectBlock];
}

- (instancetype)initWithFrame:(CGRect)frame selectBlock:(GroupSelectBlock)selectBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        _table = [[URTableView alloc]initWithFrame:frame];
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
        _table.showsHorizontalScrollIndicator = NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_table];
        [_table registerNib:[UINib nibWithNibName:@"DDCommunityHeaderCell" bundle:nil] forCellReuseIdentifier:headerCell];
        _block = selectBlock;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _dataSource.count<4?SCREEN_WIDTH/_dataSource.count:100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDCommunityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCell];
    [cell setData:_dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DDCommounityModel *Model = _dataSource[indexPath.row];
    NSMutableArray *array = [NSMutableArray new];
    for (DDCommounityModel *m in _dataSource) {
        m.select = NO;
        [array addObject:m];
    }
    _dataSource = array;
    Model.select = !Model.select;
    [_dataSource replaceObjectAtIndex:indexPath.row withObject:Model];
    [tableView reloadData];
    if (_block) {
        _block(indexPath.row,Model);
    }
}

- (void)setDataSource:(NSMutableArray *)dataSource
{
    if ([dataSource isKindOfClass:[NSMutableArray class]]) {
        if (dataSource.count == _dataSource.count || dataSource.count<=0) {
            return;
        }
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0;i<dataSource.count;i++) {
            NSDictionary *dic = dataSource[i];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                DDCommounityModel *m = [DDCommounityModel new];
                m.name = dic[@"title"];
                m.type = [dic[@"type"]integerValue];
                if (m.type==3) {
                    m.groupId=[dic[@"groupid"]integerValue];
                }
                if (i==0) {
                    m.select = YES;
                }
                m.dic = dic;
                [array addObject:m];
            }
        }
        _dataSource = array;
        [_table reloadData];
    }
    
}
@end
