//
//  DDSelectClassActionView.m
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSelectClassActionView.h"
#import "DDRoutineActionView.h"

@interface DDSelectClassActionView ()
@property (nonatomic, strong) DDRoutineActionView *actionView;
@end

@implementation DDSelectClassActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)show:(NSMutableArray *)dataSource handler:(ClassListHandler)handler singleFlg:(BOOL)flg
{
    @WeakObj(self);
    if (_actionView) {
        [_actionView setData:dataSource handler:^(NSMutableArray *array) {
            handler(array);
            [selfWeak dismiss];
        } singleFlg:flg];
    }
    [self makeKeyAndVisible];
    [UIView animateWithDuration:0.25 animations:^{
        _actionView.frame = CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 300);
        self.hidden = NO;
    }];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelNormal;
        self.backgroundColor = RGBA(0, 0, 0, 0.25);
        _actionView  = [[[NSBundle mainBundle] loadNibNamed:@"DDRoutineActionView" owner:nil options:nil] lastObject];
        _actionView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        [self addSubview:_actionView];
    }
    return self;
}

- (void)show{
    
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
