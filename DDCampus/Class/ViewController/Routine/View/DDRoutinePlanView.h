//
//  DDRoutinePlanView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDRoutinePlanView : UIView
@property (weak, nonatomic) IBOutlet UILabel *weeknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkallitemLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)setData:(NSDictionary *)dic;
@end
