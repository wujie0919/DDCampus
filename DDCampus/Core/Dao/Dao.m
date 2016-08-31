//
//  Dao.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/23.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "Dao.h"

static FMDatabaseQueue *dbQueue;


@implementation Dao

DEF_SINGLETON(Dao)


- (void)initDataBaseQueueWithPath:(NSString *)path
{
    if(!dbQueue){
        dbQueue = [[FMDatabaseQueue alloc] initWithPath:path];
    }
}
/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/

- (void)inDatabase:(DatabaseBlock)block{
    if (!block) {
        return;
    }
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db setTraceExecution:YES];
        block(db);
    }];
}
- (void)inTransaction:(TransactionBlock)block{
    if (!block) {
        return;
    }
    [dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db setTraceExecution:YES];
        block(db,rollback);
        if (*rollback == YES) {
            DDLogError(@"数据库出错--->error:%@",[db lastErrorMessage]);
        }
    }];
}


@end
