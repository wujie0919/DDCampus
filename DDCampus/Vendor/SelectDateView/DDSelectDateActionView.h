//
//  DDSelectDateActionView.h
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDateBlock)(NSString *date);
@interface DDSelectDateActionView : UIWindow
@property (nonatomic, copy) SelectDateBlock dateBlock;
+ (instancetype)actionViewWithFrame:(CGRect)frame;
- (void)show;
@end
