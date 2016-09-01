//
//  DDScoreInfoView.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectClassClickHandler)(NSInteger tag);

@interface DDScoreInfoView : UIView
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) SelectClassClickHandler handler;
- (void)setColorFrame:(NSInteger)index;
@end
