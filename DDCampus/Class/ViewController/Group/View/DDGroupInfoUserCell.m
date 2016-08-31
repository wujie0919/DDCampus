//
//  DDGroupInfoUserCell.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGroupInfoUserCell.h"
#import "DDUserHeaderCollectionCell.h"
static NSString * headerCell = @"headerCell";

@interface DDGroupInfoUserCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy) NSArray *array;
@end

@implementation DDGroupInfoUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_collectionview registerNib:[UINib nibWithNibName:@"DDUserHeaderCollectionCell" bundle:nil] forCellWithReuseIdentifier:headerCell];
    _collectionview.delegate = self;
    _collectionview.userInteractionEnabled = NO;
    _collectionview.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(NSDictionary *)data
{
    if ([data[@"groupuserlist"]isKindOfClass:[NSArray class]]) {
        _array = data[@"groupuserlist"];
        [_collectionview reloadData];
    }
    _valueLabel.text = [NSString stringWithFormat:@"群名片（%@）",data[@"groupcount"]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _array.count>5?5:_array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDUserHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:headerCell forIndexPath:indexPath];
    if ([_array[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        [cell setValue:_array[indexPath.row][@"pic"]];
    }
    
    return cell;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){50 ,50};
}

@end
