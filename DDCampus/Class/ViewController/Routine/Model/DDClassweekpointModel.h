//
//  DDClassweekpointModel.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDClassweekpointModel : NSObject
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, copy) NSString *class_year;
@property (nonatomic, copy) NSString *weekplanid;
@property (nonatomic, copy) NSString *weekname;
@property (nonatomic, copy) NSString *startday;
@property (nonatomic, copy) NSString *endday;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *cursort;
@property (nonatomic, copy) NSArray *cut_subject;
@property (nonatomic, assign) BOOL showAll;
@end
