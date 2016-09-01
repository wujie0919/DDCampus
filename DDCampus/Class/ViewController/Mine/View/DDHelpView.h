//
//  DDHelpView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHelpView : UIView
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *daanLabel;
@property (nonatomic, assign) CGFloat height;
- (void)setData:(NSDictionary *)dic;
@end
