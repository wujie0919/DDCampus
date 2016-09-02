//
//  DDRoutinePlanView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinePlanView.h"
#import "DDRoutinPlanInfoCell.h"

static NSString * const planCell = @"planCell";
@interface DDRoutinePlanView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSArray *array;
@end

@implementation DDRoutinePlanView

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
    _dataTable.delegate = self;
    _dataTable.dataSource =self;
    _array = [NSArray array];
    [_dataTable registerNib:[UINib nibWithNibName:@"DDRoutinPlanInfoCell" bundle:nil] forCellReuseIdentifier:planCell];
    _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    @WeakObj(self);
    [_weeknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [_checkallitemLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.weeknameLabel.mas_bottom).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.left.equalTo(selfWeak).offset(10);
    }];
    [_dataTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.checkallitemLabel.mas_bottom).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.bottom.equalTo(selfWeak).offset(-20);
        make.left.equalTo(selfWeak).offset(10);
    }];
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.dataTable.mas_bottom).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.bottom.equalTo(selfWeak).offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    _dataTable.userInteractionEnabled = NO;
}

- (void)setData:(NSDictionary *)dic
{
    _weeknameLabel.text = dic[@"weekname"];
    _dateLabel.text = [NSString stringWithFormat:@"%@-%@",[NSDate getDateValue:dic[@"startday"] format:@"MM月dd"],[NSDate getDateValue:dic[@"endday"] format:@"MM月dd"]];
    _checkallitemLabel.text = [NSString stringWithFormat:@"值周内容:%@",dic[@"checkallitem"]];
    _classLabel.text = dic[@"class_name"];
    if ([dic[@"weeklist"]isKindOfClass:[NSArray class]]) {
        _array = dic[@"weeklist"];
        [_dataTable reloadData];
        _dataTable.frame = CGRectMake(10, CGRectGetMaxY(_checkallitemLabel.frame), self.frame.size.width, _array.count*72);
//        [_dataTable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(selfWeak.weeknameLabel.mas_bottom).offset(10);
//            make.right.equalTo(selfWeak).offset(-10);
//            make.left.equalTo(selfWeak).offset(10);
//            make.height.mas_equalTo(selfWeak.array.count*72);
//        }];
    }
    _height = _dataTable.frame.size.height+_dataTable.frame.origin.y+30;
//    _height = CGRectGetMaxY(_classLabel.frame);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDRoutinPlanInfoCell *cell = (DDRoutinPlanInfoCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
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
    DDRoutinPlanInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:planCell];
    [cell setCellData:_array[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
