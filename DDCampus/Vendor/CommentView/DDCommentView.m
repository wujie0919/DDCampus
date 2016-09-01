//
//  DDCommentView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommentView.h"

@implementation DDCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)initComment:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _textView = [[UITextView alloc]init];
        [self addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.masksToBounds = YES;
        @WeakObj(self);
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selfWeak).offset(5);
            make.left.equalTo(selfWeak).offset(10);
            make.right.equalTo(selfWeak).offset(-10);
            make.bottom.equalTo(selfWeak).offset(-5);
        }];
    }
    return self;
}

@end
