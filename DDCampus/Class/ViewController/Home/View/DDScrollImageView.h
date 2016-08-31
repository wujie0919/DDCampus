//
//  DDScrollImageView.h
//  DDCampus
//
//  Created by wu on 16/8/19.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTLoopScrollView.h"
@interface DDScrollImageView : UIView<UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) XTLoopScrollView *loopScroll;
- (void)setScrollviewContent:(NSArray *)imageArray;
@end
