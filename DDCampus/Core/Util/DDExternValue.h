//
//  DDExternValue.h
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

extern NSString * const uid;
extern NSString * const token;
extern NSString * const mobile;
extern NSString * const pwd;
extern NSString * const DDLoginStatus;
extern NSString * const UserInfo;
extern AppDelegate * appDelegate;
extern NSString * const PicUrl;
extern NSString * const DataKey;
extern NSString * const LikeStartValue;
extern NSString * const classid;
extern NSString * const classname;
extern NSString * const GetClassNameSuccess;

/** 点击朋友圈全文的通知 */
extern NSString *const LZCommentClickedNotification;
extern NSString *const LZCommentClickedNotificationKey;
extern NSString * const LZCommentViewNoticationKey;


extern NSString * const NewMessageNotRead;

extern NSString * const TOKENOVERDUE;
@interface DDExternValue : NSObject

@end
