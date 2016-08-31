//
//  DDRoutineActionView.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickHandler)(NSMutableArray *array);

@interface DDRoutineActionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *studentData;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
- (void)setData:(NSMutableArray *)array handler:(ButtonClickHandler) handler singleFlg:(BOOL)flg;
@end
