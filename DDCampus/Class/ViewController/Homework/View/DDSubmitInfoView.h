//
//  DDSubmitInfoView.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSubmitInfoView : UIView

@property (nonatomic, strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (nonatomic, assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet DDTableView *submitTable;
@end
