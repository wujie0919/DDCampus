//
//  DDRoutineBtnView.h
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RoutineButtonClickHandler)(NSInteger tag);

@interface DDRoutineBtnView : UIView
@property (weak, nonatomic) IBOutlet UIButton *weekButton;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *dayButton;
@property (nonatomic , copy) RoutineButtonClickHandler clickHandler;
- (void)setColorFrame:(NSInteger)btnTag;
@end
