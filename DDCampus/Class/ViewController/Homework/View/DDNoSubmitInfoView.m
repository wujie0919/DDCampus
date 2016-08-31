//
//  DDNoSubmitInfoView.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDNoSubmitInfoView.h"
#import "DDUnSubmitValueCell.h"

static NSString * const valueCell = @"valueCell";

@implementation DDNoSubmitInfoView

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
    [_unSubmitCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.lineLabel.mas_bottom).offset(10);
        make.bottom.equalTo(selfWeak).offset(0);
        make.left.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
    }];
    _array= [NSArray array];
    [_unSubmitCollectionView registerNib:[UINib nibWithNibName:@"DDUnSubmitValueCell" bundle:nil] forCellWithReuseIdentifier:valueCell];
    _unSubmitCollectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    [_unSubmitCollectionView reloadData];
    @WeakObj(self);
    [_unSubmitCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.lineLabel.mas_bottom).offset(10);
        make.left.equalTo(selfWeak).offset(10);
        make.right.equalTo(selfWeak).offset(-10);
        make.height.offset(array.count*40);
    }];
    _height = CGRectGetMaxY(_lineLabel.frame)+10+array.count*40;
}

#pragma mark - UICollectionView delegate and datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _array.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDUnSubmitValueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:valueCell forIndexPath:indexPath];
    [cell setValueData:_array[indexPath.row]];
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-20)/2, 40);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
