//
//  DDScoreInfoView.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScoreInfoView.h"

@interface DDScoreInfoView ()
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIFont *font;

@end

@implementation DDScoreInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-2)];
        _scrollview.pagingEnabled = YES;
        _scrollview.bounces = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollview];
        _font = [UIFont systemFontOfSize:14];
        _buttonColor = [UIColor blackColor];
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineLabel];
        
        _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-2, 0, 3)];
        _colorLabel.backgroundColor = RGB(101, 200, 126);
        [self addSubview:_colorLabel];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    CGFloat width = 50;
    if (_titleArray.count<=4) {
        width = SCREEN_WIDTH/_titleArray.count;
    }
    _scrollview.contentSize = CGSizeMake(width*_titleArray.count, self.frame.size.height-2);
    for (int i =0;i<_titleArray.count;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, self.frame.size.height-2);
        button.tag = i;
        button.titleLabel.font = _font;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:_buttonColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:button];
    }
    [self setColorFrame:0];
}
- (void)setColorFrame:(NSInteger)index
{
    if (index>=0 && index<_titleArray.count) {
        CGFloat width = 50;
        if (_titleArray.count<=4) {
            width = SCREEN_WIDTH/_titleArray.count;
        }
        @WeakObj(self);
        [UIView animateWithDuration:0.25 animations:^{
            selfWeak.colorLabel.frame = CGRectMake(index*width, self.frame.size.height-2, width, 3);
        }];
    }
}
- (void)btnClick:(UIButton *)button
{
    [self setColorFrame:button.tag];
    if (_handler) {
        _handler(button.tag);
    }
}
@end
