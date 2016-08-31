//
//  DDHomeworkModel.h
//  DDCampus
//
//  Created by wu on 16/8/17.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHomeworkModel : NSObject
@property (nonatomic, copy) NSString *homework_title;
@property (nonatomic, copy) NSString *homework_status;
@property (nonatomic, copy) NSString *homework_content;
@property (nonatomic, copy) NSString *teacherid_usertype;
@property (nonatomic, copy) NSString *homework_id;
@property (nonatomic, copy) NSString *homework_classid;
@property (nonatomic, copy) NSString *homework_teacherid;
@property (nonatomic, copy) NSString *homewrok_dohave;
@property (nonatomic, copy) NSString *homework_dateline;
@property (nonatomic, copy) NSString *homework_class_year;
@property (nonatomic, copy) NSString *homework_class_name;
@property (nonatomic, copy) NSString *homework_teacher_name;
@property (nonatomic, copy) NSString *homework_doneid;
@property (nonatomic, copy) NSString *homework_isdone;
@end
