//
//  NSObject+Network.m
//  DDCampus
//
//  Created by wu on 16/8/9.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "NSObject+Network.h"
#import "NSData+Custom.h"

id JSONObjectByRemovingKeysWithNullValues(id JSONObject) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:JSONObjectByRemovingKeysWithNullValues(value)];
        }
        return mutableArray;
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = [(NSDictionary *)JSONObject objectForKey:key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                [mutableDictionary setObject:JSONObjectByRemovingKeysWithNullValues(value) forKey:key];
            }
        }
        return mutableDictionary;
    }
    return JSONObject;
}

static NSString * const HOST = @"http://dingding.wangjuyunhe.com/api.php?m=index&a=";

@implementation NSObject (Network)

- (AFHTTPRequestOperation *)Network_Post:(NSString *)module tag:(NSInteger)tag param:(NSDictionary *)param success:(successBlock)success failure:(failureBlock)failure{
    return [self POST:[NSString stringWithFormat:@"%@%@",HOST,module]
                  tag:tag params:^(NSMutableDictionary *params) {
                      for (NSString *key in [param allKeys] ) {
                          if([key isEqualToString:@"pic1"] || [key isEqualToString:@"pic2"] || [key isEqualToString:@"pic3"] || [key isEqualToString:@"headerimg"]) continue;
                          [params setValue:param[key] forKey:key];
                      }
                      if (tag != Login_Tag) {
                          [params setValue:[USER_DEFAULT objectForKey:uid] forKey:uid];
                          [params setValue:[USER_DEFAULT objectForKey:token] forKey:token];
                      }
                  } bodyPart:^(id<AFMultipartFormData> formData) {
                      if (tag == Do_forumpost_Tag || tag ==Do_saveheadpic_Tag) {
                          for (NSString *key in [param allKeys] ) {
                              if([key isEqualToString:@"pic1"] || [key isEqualToString:@"pic2"] || [key isEqualToString:@"pic3"] || [key isEqualToString:@"headerimg"]) {
                                  [formData appendPartWithFileData:param[key] name:key fileName:@"temp.jpg" mimeType:@"image/jpeg"];
                              }
                              else
                              {
                                  continue;
                              }
                          }
                      }
                  } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      id obj = [responseObject objectFromJSONData];
                      obj = JSONObjectByRemovingKeysWithNullValues(obj);
                      if (success) {
                          success(obj);
                          if ([obj[@"code"] integerValue]==405) {
                              [[NSNotificationCenter defaultCenter] postNotificationName:TOKENOVERDUE object:self userInfo:nil];
                          }
                      }
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      failure(error);
                  }];
}
@end
