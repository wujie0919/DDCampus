//
//  DDPublishHomeworkController.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDPublishHomeworkController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDView *selectClassView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *selectView;
@end
