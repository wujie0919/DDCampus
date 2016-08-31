//
//  DDRankHeaderView.h
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRankHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

- (void)setHeaderValue:(NSArray *)array;
@end
