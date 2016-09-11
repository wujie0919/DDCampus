//
//  DDShowKouFenView.h
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDShowKouFenView : UIView

@property (nonatomic, copy) void (^ClickAction)(NSString *value);

- (void)showWithTitle:(NSString *)title;

@end
