//
//  DDRoutineDetailsModel.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRoutineDetailsModel : NSObject
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *studentallid;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, strong) NSMutableArray *student_id;
@property (nonatomic, strong) NSMutableArray *student_name;
@property (nonatomic, strong) NSMutableArray *allstudentlist;
@end
