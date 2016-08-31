//
//  DDRoutineStudentCollectionCell.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDRoutineSelectStudentModel.h"

@interface DDRoutineStudentCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
- (void)setValue:(DDRoutineSelectStudentModel *)model;
@end
