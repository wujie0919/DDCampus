//
//  DDHomeworkDetailsModel.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHomeworkDetailsModel : NSObject
@property (nonatomic,copy) NSString *homework_id;
@property (nonatomic,copy) NSString *classid;
@property (nonatomic,copy) NSString *teacherid;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *dohave;
@property (nonatomic,copy) NSString *dateline;
@property (nonatomic,copy) NSString *updateline;
@property (nonatomic,copy) NSString *class_year;
@property (nonatomic,copy) NSString *class_name;
@property (nonatomic,copy) NSString *teacher_name;
@property (nonatomic,copy) NSDictionary *donedata;
@end
