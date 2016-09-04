//
//  DDScoreDetailsView.m
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreDetailsView.h"
#import "DDScoreDetailsCollectionCell.h"

static NSString * detailsCell = @"detailsCell";

@implementation DDScoreDetailsView

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
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.height.mas_equalTo(20);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.collectionView.mas_bottom).offset(5);
        make.left.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DDScoreDetailsCollectionCell" bundle:nil] forCellWithReuseIdentifier:detailsCell];
    _collectionView.userInteractionEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)setViewData:(NSDictionary *)dic
{
    _nameLabel.text = dic[@"student_name"];
    _countLabel.text = [NSString stringWithFormat:@"总分：%@",dic[@"score_sum"]];
    _height = 40;
    if ([dic[@"subject"]isKindOfClass:[NSArray class]]) {
        _array = dic[@"subject"];
        [_collectionView reloadData];
        @WeakObj(self);
        if (_array.count<=3) {
            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(10);
                make.left.equalTo(selfWeak).offset(10);
                make.right.equalTo(selfWeak).offset(-10);
                make.height.mas_equalTo(20);
            }];
            _height = _height+30;
        }
        else
        {
            if (_array.count%3 == 0) {
//                _infoView.frame = CGRectMake(20, _height+10, 200, (_array.count/3)*20);
                _height = _height+(_array.count/3)*20+((_array.count/3)*5);
                [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(10);
                    make.left.equalTo(selfWeak).offset(10);
                    make.right.equalTo(selfWeak).offset(-10);
                    make.height.mas_equalTo((_array.count/3)*20);
                }];
            }
            else
            {
//                _infoView.frame = CGRectMake(20, _height+10, 200, (_array.count%3)*20);
                _height = _height+(_array.count%3)*20+(_array.count%3)*5;
                [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(selfWeak.nameLabel.mas_bottom).offset(10);
                    make.left.equalTo(selfWeak).offset(10);
                    make.right.equalTo(selfWeak).offset(-10);
                    make.height.mas_equalTo((_array.count%3)*20);
                }];
            }
            
        }
        [_countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak.collectionView.mas_bottom).offset(5);
            make.left.equalTo(selfWeak).offset(10);
            make.right.equalTo(selfWeak).offset(-10);
            make.height.mas_equalTo(20);
        }];
    }
    _height = _height + 30;
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
    DDScoreDetailsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailsCell forIndexPath:indexPath];
    [cell setNameValue:_array[indexPath.row]];
    return cell;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){60 ,20};
}
@end
