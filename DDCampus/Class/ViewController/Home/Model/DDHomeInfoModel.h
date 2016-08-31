//
//  DDHomeInfoModel.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHomeInfoModel : NSObject
@property (nonatomic, copy) NSDictionary *homeDic;
@property (nonatomic) BOOL isExpand;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) BOOL showComment;
@end
