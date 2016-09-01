//
//  DDStudentScoreView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDStudentScoreView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *infoView;
@property (nonatomic, assign) CGFloat height;
- (void)setData:(NSDictionary *)dic;
@end
