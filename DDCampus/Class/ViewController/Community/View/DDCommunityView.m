//
//  DDCommunityView.m
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCommunityView.h"
#import "URTableView.h"
#import "DDCommunityCell.h"

static NSString * const cellIden=@"cellIden";

@interface DDCommunityView ()
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIFont *font;

@end

@implementation DDCommunityView

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
//        _scrollview.bounces = NO;
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
        _colorLabel.hidden = YES;
        [self addSubview:_colorLabel];
    }
    return self;
}

- (void)setDataArray:( NSMutableArray<NSDictionary *> * _Nonnull )dataArray
{
    
    _dataArray = dataArray;
    CGFloat width = 90;
    if (_dataArray.count<=3) {
        width = SCREEN_WIDTH/_dataArray.count;
    }
    _scrollview.contentSize = CGSizeMake(width*_dataArray.count, self.frame.size.height-2);
    for (int i =0;i<_dataArray.count;i++) {
        NSDictionary *dic  = _dataArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, self.frame.size.height-2);
        button.tag = i;
        button.titleLabel.font = _font;
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:_buttonColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:button];
    }
    [self setColorFrame:0];
}


- (void)btnClick:(UIButton *)button
{
    [self setColorFrame:button.tag];
    if (_handler) {
        _handler(button.tag);
    }
}

- (void)setColorFrame:(NSInteger)index
{
    if (_colorLabel.hidden) {
        _colorLabel.hidden = NO;
    }
    if (index>=0 && index<self.dataArray.count) {
        CGFloat width = 90;
        if (_dataArray.count<=3) {
            width = SCREEN_WIDTH/_dataArray.count;
        }
        @WeakObj(self);
        [UIView animateWithDuration:0.25 animations:^{
            if(index*width > SCREEN_WIDTH){
                [self.scrollview setContentOffset:CGPointMake(index*width-width, 0) animated:YES];
                selfWeak.colorLabel.frame = CGRectMake(index*width-width, self.frame.size.height-2, width, 3);
                
            }else{
                selfWeak.colorLabel.frame = CGRectMake(index*width, self.frame.size.height-2, width, 3);
                [self.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }];
        
//        if(originX - self.contentOffset.x < 5){
//            [self setContentOffset:CGPointMake(originX, 0) animated:YES];
//        }
    }
}

@end
