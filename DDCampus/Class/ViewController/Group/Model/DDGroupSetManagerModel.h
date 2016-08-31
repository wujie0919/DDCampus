//
//  DDGroupSetManagerModel.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDGroupSetManagerModel : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *joindateline;
@property (nonatomic, copy) NSString *sqdateline;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) BOOL select;
@end
