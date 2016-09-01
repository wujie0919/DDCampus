//
//  DDTrendView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTrendView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *avgView;
@property (weak, nonatomic) IBOutlet UIButton *maxView;
@property (weak, nonatomic) IBOutlet UIButton *minView;

- (void)setData:(NSDictionary *)dic;
@end
