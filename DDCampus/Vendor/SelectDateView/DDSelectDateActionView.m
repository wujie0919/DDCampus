//
//  DDSelectDateActionView.m
//  DDCampus
//
//  Created by wu on 16/9/2.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSelectDateActionView.h"
#import "DDSelectDateView.h"

@interface DDSelectDateActionView ()
@property (nonatomic, strong) DDSelectDateView *actionView;
@end

@implementation DDSelectDateActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)actionViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _actionView  = [[[NSBundle mainBundle] loadNibNamed:@"DDSelectDateView" owner:nil options:nil] lastObject];
        _actionView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        [self addSubview:_actionView];
        self.windowLevel = UIWindowLevelNormal;
        self.backgroundColor = RGBA(0, 0, 0, 0.25);
    }
    return self;
}

- (void)show
{
    if (_actionView) {
        @WeakObj(self);
        _actionView.handler = ^(NSString *date)
        {
            if (selfWeak.dateBlock) {
                selfWeak.dateBlock(date);
            }
            [selfWeak dismiss];
        };
    }
    
    [self makeKeyAndVisible];
    [UIView animateWithDuration:0.25 animations:^{
        _actionView.frame = CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 300);
        self.hidden = NO;
    }];

}

- (void)dismiss {
    [self resignKeyWindow];
    [UIView animateWithDuration:0.25 animations:^{
        _actionView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        self.hidden = YES;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 点击消失
    [self dismiss];
}
@end
