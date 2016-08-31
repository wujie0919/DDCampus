//
//  DDCommunityView.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickHandler)(NSInteger tag);

@interface DDCommunityView : UIView
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) ButtonClickHandler handler;
- (void)setColorFrame:(NSInteger)index;
@end
