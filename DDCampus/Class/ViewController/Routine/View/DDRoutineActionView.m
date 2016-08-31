//
//  DDRoutineActionView.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineActionView.h"
#import "DDRoutineStudentCollectionCell.h"
#import "DDRoutineSelectStudentModel.h"

static NSString * const selectCell = @"selectCell";

@interface DDRoutineActionView ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) ButtonClickHandler bcHandler;
@property (nonatomic, strong) DDRoutineSelectStudentModel *selectModel;
@property (nonatomic, assign) BOOL flg;
@end

@implementation DDRoutineActionView

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
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius=5;
    _sureButton.layer.backgroundColor = RGB(101, 200, 126).CGColor;
    [_studentData registerNib:[UINib nibWithNibName:@"DDRoutineStudentCollectionCell" bundle:nil] forCellWithReuseIdentifier:selectCell];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)setData:(NSMutableArray *)array handler:(ButtonClickHandler)handler singleFlg:(BOOL)flg
{
    _bcHandler = handler;
    _flg = flg;
    _dataArray = array;
    [_studentData reloadData];
}

#pragma mark - UICollectionView delegate and datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDRoutineStudentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectCell forIndexPath:indexPath];
    [cell setValue:_dataArray[indexPath.row]];
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    if (!_flg) {
        _selectModel = _dataArray[index];
        _selectModel.selected = YES;
        for (DDRoutineSelectStudentModel *model in _dataArray) {
            if ([_selectModel.class_id isEqualToString:model.class_id]) {
                continue;
            }
            model.selected = NO;
        }
    }else
    {
        DDRoutineSelectStudentModel *model=_dataArray[index];
        model.selected = !model.selected;
        [_dataArray replaceObjectAtIndex:index withObject:model];
    }
    [collectionView reloadData];
}
- (IBAction)sureClick:(id)sender {
    NSMutableArray *array = [NSMutableArray new];
    if (!_flg) {
        if (!_selectModel) {
            for (DDRoutineSelectStudentModel *model in _dataArray) {
                if (model.selected) {
                    _selectModel = model;
                    break;
                }
            }
        }
        [array addObject:_selectModel];
    }else
    {
        array = _dataArray;
    }
    _selectModel = nil;
    _bcHandler(array);
}
@end
