//
//  DDCommunityHeaderView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCommounityModel;

typedef void(^GroupSelectBlock)(NSInteger tag,DDCommounityModel *model);

@interface DDCommunityHeaderView : UIView
@property (nonatomic, strong) NSMutableArray *dataSource;
+(instancetype)headerView:(CGRect)frame selectBlock:(GroupSelectBlock)selectBlock;
@end
