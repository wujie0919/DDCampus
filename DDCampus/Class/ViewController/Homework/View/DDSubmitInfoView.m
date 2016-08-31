//
//  DDSubmitInfoView.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSubmitInfoView.h"
#import "DDSubmitValueCell.h"

static NSString * const valueCell = @"valueCell";
@interface DDSubmitInfoView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DDSubmitInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    @WeakObj(self);
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.mas_top).with.offset(10);
        make.left.equalTo(selfWeak).with.offset(10);
        make.right.equalTo(selfWeak).with.offset(-10);
        make.height.offset(20);
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.infoLabel.mas_bottom).with.offset(10);
        make.left.equalTo(selfWeak).with.offset(10);
        make.right.equalTo(selfWeak).with.offset(-10);
        make.height.offset(1);
    }];
    [_submitTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.lineLabel.mas_bottom).offset(10);
        make.bottom.equalTo(selfWeak).offset(0);
        make.left.equalTo(selfWeak).with.offset(10);
        make.right.equalTo(selfWeak).with.offset(-10);
    }];
    _submitTable.rowHeight = 44;
    _submitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _array = [NSArray array];
    [_submitTable registerNib:[UINib nibWithNibName:@"DDSubmitValueCell" bundle:nil] forCellReuseIdentifier:valueCell];
    
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
    DDSubmitValueCell *cell = [tableView dequeueReusableCellWithIdentifier:valueCell];
    [cell setValue:_array[indexPath.row]];
    return cell;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    [_submitTable reloadData];
    @WeakObj(self);
    [_submitTable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.lineLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak).with.offset(10);
        make.right.equalTo(selfWeak).with.offset(-10);
        make.height.offset(array.count*44);
    }];
    _height = CGRectGetMaxY(_lineLabel.frame)+10+array.count*44;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
