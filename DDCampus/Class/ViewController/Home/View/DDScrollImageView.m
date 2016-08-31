//
//  DDScrollImageView.m
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDScrollImageView.h"

@implementation DDScrollImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)moveImage
{
    if (_array.count>0) {
        
    }
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];

}

- (void)setScrollviewContent:(NSArray *)imageArray
{
    if (_array.count == imageArray.count) {
        return;
    }
    
    _array = imageArray;
    NSMutableArray *imageList = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic in imageArray) {
        if ([dic[@"litpic"] isValidString]) {
            [imageList addObject:[NSString stringWithFormat:@"%@%@",PicUrl,dic[@"litpic"]]];
        }
    }
    _loopScroll = [[XTLoopScrollView alloc] initWithFrame:self.frame
                                             andImageList:imageList
                                                  canLoop:YES
                                                 duration:10.0] ;
    
    _loopScroll.color_pageControl        = [UIColor whiteColor] ;
    _loopScroll.color_currentPageControl = [UIColor grayColor] ;
    
    [self addSubview:_loopScroll] ;
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
//{
//    NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
//    [_pageview setCurrentPage:index];
//}

@end
