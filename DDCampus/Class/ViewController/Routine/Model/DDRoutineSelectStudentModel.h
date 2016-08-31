//
//  DDRoutineSelectStudentModel.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRoutineSelectStudentModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) NSString *class_id;
@end
