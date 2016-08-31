//
//  NSTools.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/18.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSTools.h"
#import "DDUserModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

static NSString *const prefix=@"ycb_";

@implementation NSTools

+ (NSString *)getClientId
{
    NSString *time=[[NSDate alloc] dateSince1970];
    return [NSString stringWithFormat:@"%@%@",prefix,time];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [USER_DEFAULT setObject:obj forKey:key];
    [USER_DEFAULT synchronize];
}

+ (DDUserModel *)getUserInfo
{
    DDUserModel *user = [DDUserModel new];
    NSDictionary *dic = [USER_DEFAULT objectForKey:UserInfo];
    user.type = dic[@"type"];
    user.binduid = dic[@"binduid"];
    user.user_id = dic[@"id"];
    user.classallid = dic[@"classallid"];
    user.mobile = dic[@"mobile"];
    user.name = dic[@"name"];
    user.nickname = dic[@"nickname"];
    user.pic = dic[@"pic"];
    user.regtime = dic[@"regtime"];
    user.viewdateline = dic[@"viewdateline"];
    user.schoolid = dic[@"schoolid"];
    user.sex = dic[@"sex"];
    user.subjectallid = dic[@"subjectallid"];
    return user;
}

/**
 *  判断相机是否可用
 *
 *  @return 结果
 */
+ (BOOL)isCameraAvalible
{
    BOOL result = YES;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        result = NO;
    }
    return result;
}
@end
