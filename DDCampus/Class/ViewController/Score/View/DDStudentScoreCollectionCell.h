//
//  DDStudentScoreCollectionCell.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDStudentScoreCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
- (void)setValue:(NSDictionary *)dic;
@end
