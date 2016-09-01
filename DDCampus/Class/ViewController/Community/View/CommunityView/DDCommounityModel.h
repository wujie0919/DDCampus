//
//  DDCommounityModel.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCommounityModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) NSInteger groupId;
@end
