//
//  Core.h
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "UIColor+Custom.h"
#import "NSData+Custom.h"
#import "NSArray+Custom.h"
#import "NSDate+Custom.h"
#import "NSDictionary+Custom.h"
#import "NSMutableDictionary+HTTP.h"
#import "NSObject+Custom.h"
#import "NSString+Custom.h"
#import "UIColor+Custom.h"
#import "UIImage+Custom.h"
#import "UIView+Custom.h"
#import "UITextView+Custom.h"
#import "UITextField+Custom.h"
#import "UIButton+Custom.h"
#import "NSObject+HTTP.h"
#import "UITableView+Custom.h"
#import "NSTools.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "NSString+DD.h"
#import "DDTextField.h"
#import "DDButton.h"
#import "SVProgressHUD.h"
#import "DDTableView.h"
#import "DDTextView.h"
#import "NSObject+Network.h"
#import "MBProgressHUD+TCM.h"
#import "DDTag.h"
#import "DDExternValue.h"
#import "DDView.h"
#import "DDImageView.h"



static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#undef	AS_SINGLETON
#define AS_SINGLETON(class) \
+ (instancetype)sharedInstance; \
+ (void)distroyInstance;


#undef	DEF_SINGLETON
#define DEF_SINGLETON(class) \
static class *sharedInstance##class; \
+ (instancetype)sharedInstance { \
@synchronized (self) { \
if (sharedInstance##class == nil) { \
sharedInstance##class = [[self alloc] init]; \
} \
} \
return sharedInstance##class; \
} \
+ (void)distroyInstance { \
@synchronized (self) { \
sharedInstance##class = nil; \
} \
}


