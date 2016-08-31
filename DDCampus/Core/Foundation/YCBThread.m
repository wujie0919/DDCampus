//
//  YCBThread.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/3.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "YCBThread.h"

@interface YCBThread(){
    dispatch_queue_t _foreQueue;
    dispatch_queue_t _backQueue;
}

AS_SINGLETON(YCBThread)

@end



@implementation YCBThread

DEF_SINGLETON(YCBThread)

- (id)init{
    self = [super init];
    if ( self ){
        _foreQueue = dispatch_get_main_queue();
        _backQueue = dispatch_queue_create( "com.XT.TaskQueue", nil );
    }
    
    return self;
}

+ (dispatch_queue_t)foreQueue{
    return [[YCBThread sharedInstance] foreQueue];
}

- (dispatch_queue_t)foreQueue{
    return _foreQueue;
}

+ (dispatch_queue_t)backQueue{
    return [[YCBThread sharedInstance] backQueue];
}

- (dispatch_queue_t)backQueue{
    return _backQueue;
}

+ (void)enqueueForeground:(dispatch_block_t)block{
    return [[YCBThread sharedInstance] enqueueForeground:block];
}

- (void)enqueueForeground:(dispatch_block_t)block{
    dispatch_async( _foreQueue, block );
}

+ (void)enqueueBackground:(dispatch_block_t)block{
    return [[YCBThread sharedInstance] enqueueBackground:block];
}

- (void)enqueueBackground:(dispatch_block_t)block{
    dispatch_async( _backQueue, block );
}

+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
    [[YCBThread sharedInstance] enqueueForegroundWithDelay:ms block:block];
}

- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _foreQueue, block );
}

+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
    [[YCBThread sharedInstance] enqueueBackgroundWithDelay:ms block:block];
}

- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _backQueue, block );
}

@end
