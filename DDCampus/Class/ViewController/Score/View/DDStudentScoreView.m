//
//  DDStudentScoreView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDStudentScoreView.h"
#import "DDStudentScoreCollectionCell.h"

static NSString * score = @"score";

@interface DDStudentScoreView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation DDStudentScoreView

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
        make.top.equalTo(selfWeak).offset(5);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(20);
        make.right.equalTo(selfWeak.dateLabel.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selfWeak).offset(-5);
        make.right.equalTo(selfWeak).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [_infoView registerNib:[UINib nibWithNibName:@"DDStudentScoreCollectionCell" bundle:nil] forCellWithReuseIdentifier:score];
    _infoView.delegate = self;
    _infoView.userInteractionEnabled = NO;
    _infoView.dataSource = self;
}

- (void)setData:(NSDictionary *)dic
{
    _nameLabel.text = dic[@"name"];
    _dateLabel.text = dic[@"examtime"];
    _scoreLabel.text = [NSString stringWithFormat:@"总分：%@",dic[@"score_sum"]];
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    if ([dic[@"subject"]isKindOfClass:[NSArray class]]) {
        [data addObjectsFromArray:dic[@"subject"]];
    }
    _array = data;
    if (_array.count>0) {
        _infoView.hidden = NO;
        [_infoView reloadData];
    }
    else{
        _infoView.hidden = YES;
    }
    _height = CGRectGetMaxY(_nameLabel.frame);
    if (_array.count%3 == 0) {
        _infoView.frame = CGRectMake(20, _height+10, 200, (_array.count/3)*20);
        _height = _height+(_array.count/3)*20+((_array.count/3)*5);
    }
    else
    {
        _infoView.frame = CGRectMake(20, _height+10, 200, (_array.count%3)*20);
        _height = _height+(_array.count%3)*20+(_array.count%3)*5;
    }
    if (_height<60) {
        _height = 60;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDStudentScoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:score forIndexPath:indexPath];
    [cell setValue:_array[indexPath.row]];
    return cell;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){60 ,20};
}
@end
