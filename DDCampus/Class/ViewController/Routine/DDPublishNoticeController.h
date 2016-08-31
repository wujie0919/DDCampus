//
//  DDPublishNoticeController.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDPublishNoticeController : DDBaseViewController
@property (weak, nonatomic) IBOutlet DDView *selectClassView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UITextField *noticeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentView;
@end
