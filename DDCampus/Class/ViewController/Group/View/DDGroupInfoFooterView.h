//
//  DDGroupInfoFooterView.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewMessageBlock)();

@interface DDGroupInfoFooterView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, copy) NewMessageBlock mBlock;

@property (weak, nonatomic) IBOutlet DDButton *exitButton;
@end
