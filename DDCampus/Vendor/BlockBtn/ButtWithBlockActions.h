//
//  ButtWithBlockActions.h
//  iFileManager
//
//  Created by  on 12-2-5.
//  Copyright (c) 2012年 chinakapalink@gmail.com. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ButtWithBlockActions:UIButton {
  void (^downBlock_)(void);
  void (^upBlock_)(void);
  void (^clickedBlock_)(void);
}
@property(nonatomic,copy) void (^downBlock)(void);
@property(nonatomic,copy) void (^upBlock)(void);
@property(nonatomic,copy) void (^clickedBlock)(void);
@end
