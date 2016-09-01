//
//  DDScoreListView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreListView.h"
#import "DDTeacherScoreTableViewCell.h"

static NSString * const scell= @"scell";

@interface DDScoreListView ()
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DDScoreListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    @WeakObj(self);
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(20);
        make.right.equalTo(selfWeak.dateLabel.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    [_jianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selfWeak).offset(-10);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(10, 13));
    }];
    
    

    _scoreTable.delegate = self;
    _scoreTable.dataSource = self;
    [_scoreTable registerNib:[UINib nibWithNibName:@"DDTeacherScoreTableViewCell" bundle:nil] forCellReuseIdentifier:scell];
    _array = [NSMutableArray new];
    _scoreTable.userInteractionEnabled = NO;
    _scoreTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setData:(NSDictionary *)dic
{
    _nameLabel.text = dic[@"name"];
    _dateLabel.text = dic[@"examtime"];
    NSLog(@"%@",dic);
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    if ([dic[@"subject"][dic[@"subjectallid"]]isKindOfClass:[NSDictionary class]]) {
        [data addObject:dic[@"subject"][dic[@"subjectallid"]]];
    }
    _array = data;
    [_scoreTable reloadData];
    _height = CGRectGetMaxY(_nameLabel.frame);
    _scoreTable.frame = CGRectMake(10, _height, 290, _array.count*40);
    _height = _height+_array.count*40;
    if (_height<60) {
        _height = 60;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDTeacherScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scell];
    [cell setData:_array[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
