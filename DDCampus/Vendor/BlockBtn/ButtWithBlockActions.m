//
//  ButtWithBlockActions.m
//  iFileManager
//
//  Created by  on 12-2-5.
//  Copyright (c) 2012年 chinakapalink@gmail.com. All rights reserved.
//

#import "ButtWithBlockActions.h"

@implementation ButtWithBlockActions
- (void)dealloc {
#if !__has_feature(objc_arc)
  [downBlock_ release];
  [upBlock_ release];
  [clickedBlock_ release];
  [super dealloc];
#endif
}

- (void (^)(void))downBlock{
  return downBlock_;
}
- (void) fireDownBlock{
  downBlock_();
}
- (void) setDownBlock:(void (^)(void))block{
  if(downBlock_){
    [self removeTarget:self
                action:@selector(fireDownBlock)
      forControlEvents:UIControlEventTouchDown];
    [self removeTarget:self
                action:@selector(fireDownBlock)
      forControlEvents:UIControlEventTouchDragEnter];
#if !__has_feature(objc_arc)
    [downBlock_ release];
#endif
  }
  downBlock_ = [block copy];
  if(downBlock_) {
    [self addTarget:self
             action:@selector(fireDownBlock)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self
             action:@selector(fireDownBlock)
   forControlEvents:UIControlEventTouchDragEnter];
  }
}


- (void (^)(void))upBlock {
  return upBlock_;
}
- (void) fireUpBlock {
  upBlock_();
}
- (void) setUpBlock:(void (^)(void))block {
  if(upBlock_) {
    [self removeTarget:self
                action:@selector(fireUpBlock)
      forControlEvents:UIControlEventTouchUpInside];
    [self removeTarget:self
                action:@selector(fireUpBlock)
      forControlEvents:UIControlEventTouchUpOutside];
    [self removeTarget:self
                action:@selector(fireUpBlock)
      forControlEvents:UIControlEventTouchDragOutside];
    [self removeTarget:self
                action:@selector(fireUpBlock)
      forControlEvents:UIControlEventTouchCancel];
#if !__has_feature(objc_arc)
    [upBlock_ release];
#endif
  }
  upBlock_ = [block copy];
  if(upBlock_) {
    [self addTarget:self
             action:@selector(fireUpBlock)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self
             action:@selector(fireUpBlock)
   forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self
             action:@selector(fireUpBlock)
   forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self
             action:@selector(fireUpBlock)
   forControlEvents:UIControlEventTouchCancel];
  }
}


- (void (^)(void))clickedBlock {
  return clickedBlock_;
}
- (void) fireClickedBlock {
  clickedBlock_();
}
- (void) setClickedBlock:(void (^)(void))block {
  if(clickedBlock_) {
    [self removeTarget:self
                action:@selector(fireClickedBlock)
      forControlEvents:UIControlEventTouchUpInside];
#if !__has_feature(objc_arc)
    [clickedBlock_ release];
#endif
  }
  clickedBlock_ = [block copy];
  if(clickedBlock_) {
    [self addTarget:self
             action:@selector(fireClickedBlock)
   forControlEvents:UIControlEventTouchUpInside];
  }
}

@end
