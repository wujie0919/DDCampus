//
//  DDRoutineController.h
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseViewController.h"

@interface DDRoutineController : DDBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic, copy) NSString *selectIndex;
@end
