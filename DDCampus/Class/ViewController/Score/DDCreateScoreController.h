//
//  DDCreateScoreController.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDCreateScoreController : DDBaseViewController

@property (weak, nonatomic) IBOutlet DDView *classView;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet DDView *sujectView;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet DDView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
