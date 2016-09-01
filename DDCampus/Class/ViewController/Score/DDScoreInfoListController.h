//
//  DDScoreInfoListController.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableCellSelectBlock)(NSDictionary *dict);

@interface DDScoreInfoListController : UIViewController
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) TableCellSelectBlock block;
@end
