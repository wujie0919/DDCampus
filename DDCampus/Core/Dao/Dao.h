//
//  Dao.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/23.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "FMDatabasePool.h"


typedef void (^DatabaseBlock)(FMDatabase *db);
typedef void (^TransactionBlock)(FMDatabase *db, BOOL *rollback);

@interface Dao : NSObject

AS_SINGLETON(Dao)

- (void)initDataBaseQueueWithPath:(NSString *)path;

- (void)inDatabase:(DatabaseBlock)block;
- (void)inTransaction:(TransactionBlock)block;

@end

