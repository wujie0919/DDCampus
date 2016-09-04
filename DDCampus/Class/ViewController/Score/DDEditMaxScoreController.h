//
//  DDEditMaxScoreController.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

typedef void(^ScoreEditValueBlock)(NSDictionary *dic);

@interface DDEditMaxScoreController : DDBaseViewController
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) ScoreEditValueBlock editBlock;
@end
