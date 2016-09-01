//
//  DDCommentView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDCommentView : UIView
@property (nonatomic, strong) UITextView *textView;
+ (instancetype)initComment:(CGRect)frame;
@end
