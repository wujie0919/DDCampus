//
//  DDUserModel.h
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUserModel : NSObject
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *schoolid;
@property (nonatomic, copy) NSString *classallid;
@property (nonatomic, copy) NSString *binduid;
@property (nonatomic, copy) NSString *subjectallid;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *regtime;
@property (nonatomic, copy) NSString *viewdateline;
@end
