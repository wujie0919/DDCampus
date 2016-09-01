//
//  DDCurveViewController.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDCurveViewController : DDBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *zongheLabel;
@property (nonatomic, copy) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet DDTableView *dataTable;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;
@property (weak, nonatomic) IBOutlet UILabel *paimingLabel;
@end
