//
//  DDScoreDetailsView.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDScoreDetailsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, assign) CGFloat height;
- (void)setViewData:(NSDictionary *)dic;
@end
