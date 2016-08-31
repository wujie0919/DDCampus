//
//  DDSelectClassActionView.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClassListHandler)(NSMutableArray *nameList);

@interface DDSelectClassActionView : UIWindow

- (void)show:(NSMutableArray *)dataSource handler:(ClassListHandler)handler singleFlg:(BOOL)flg;

- (void)dismiss;

@end
