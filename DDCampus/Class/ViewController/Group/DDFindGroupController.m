//
//  DDFindGroupController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDFindGroupController.h"
#import "DDCreateGroupController.h"
#import "DDFindGroupCollectionViewCell.h"
#import "DDFindGroupModel.h"
#import "DDFindGroupReusableView.h"

static NSString * findCell = @"findCell";
static NSString * footer = @"footer";

@interface DDFindGroupController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) DDFindGroupModel *selectModel;
@end

@implementation DDFindGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    _array = [NSMutableArray arrayWithCapacity:0];
    self.title = @"发现";
    if (!_rightButton) {
        _rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.backgroundColor = RGB(48, 185, 113);
        _rightButton.frame = CGRectMake(0, 5, 100, 30);
        _rightButton.layer.cornerRadius= 5;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 1;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    }
    [_rightButton addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"创建群组" forState:UIControlStateNormal];
    [_collectionView registerNib:[UINib nibWithNibName:@"DDFindGroupCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:findCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DDFindGroupReusableView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];

    _collectionView.backgroundColor = [UIColor whiteColor];
    [self getGroupList];
}

- (void)createGroup
{
    DDCreateGroupController *createVC = [[DDCreateGroupController alloc]initWithNibName:@"DDCreateGroupController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}

- (void)getGroupList
{
    @WeakObj(self);
    [self Network_Post:@"getgrouplist" tag:Getgrouplist_Tag
                 param:nil success:^(id result) {
                     if ([result[@"code"]integerValue]==200) {
                         if ([result[DataKey][@"groupcount"]integerValue]>0) {
                             NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
                             for (NSDictionary *dic in result[DataKey][@"grouplist"]) {
                                 DDFindGroupModel *mode = [DDFindGroupModel new];
                                 mode.g_id = dic[@"id"];
                                 mode.sqdateline = dic[@"sqdateline"];
                                 mode.message = dic[@"message"];
                                 mode.title = dic[@"title"];
                                 mode.dateline = dic[@"dateline"];
                                 mode.createuid = dic[@"createuid"];
                                 [data addObject:mode];
                             }
                             _array = data;
                             [selfWeak.collectionView reloadData];
                         }
                     }
                 } failure:^(NSError *error) {
                     
                 }];
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
    DDFindGroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:findCell forIndexPath:indexPath];
    [cell setData:_array[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self reladData:indexPath.row];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){SCREEN_WIDTH/3-10 ,44};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){SCREEN_WIDTH,50};
}
  - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView   viewForSupplementaryElementOfKind:(NSString *)kind  atIndexPath:(NSIndexPath *)indexPath{
      if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
          
           UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:footer   forIndexPath:indexPath];
          DDFindGroupReusableView *footerView = (DDFindGroupReusableView *)view;
          [footerView.addButton addTarget:self action:@selector(addGroup) forControlEvents:UIControlEventTouchUpInside];
          if (_array.count<=0) {
              footerView.addButton.hidden = YES;
          }else
          {
              footerView.addButton.hidden = NO;
          }
          return view;
      }
      return nil;
      
}

- (void)addGroup
{
    @WeakObj(self);
    if (!_selectModel) {
        [self showErrorHUD:@"请选择群组"];
        return;
    }
    [self showLoadHUD:@"加入中..."];
    [self Network_Post:@"do_joingroup" tag:Do_joingroup_Tag
                 param:@{@"groupid":_selectModel.g_id} success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         if (_joinBlock) {
                             _joinBlock();
                         }
                         [selfWeak showSuccessHUD:@"加入成功成功"];
                         [selfWeak.navigationController popViewControllerAnimated:YES];
                         
                     }else
                     {
                         [selfWeak showErrorHUD:result[@"message"]];
                     }
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                     [selfWeak showErrorHUD:@"网络异常"];
                 }];
}

- (void)reladData:(NSInteger)row
{
    for (DDFindGroupModel *gModel in _array) {
        if (gModel.isSelect) {
            gModel.isSelect = NO;
            continue;
        }
    }
    DDFindGroupModel *model = _array[row];
    _selectModel = model;
    model.isSelect = !model.isSelect;
    [_array replaceObjectAtIndex:row withObject:model];
    [_collectionView reloadData];
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
