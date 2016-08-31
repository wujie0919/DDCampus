//
//  NSObject+HTTP.m
//  YCBiOSClient
//
//  Created by Aaron on 15/12/2.
//  Copyright © 2015年 ycb. All rights reserved.
//

#import "NSObject+HTTP.h"
#import "NSError+HTTP.h"
#import "NSData+Custom.h"

@implementation NSObject (HTTP)

/**********************************************************************/
#pragma mark - OverWrite Methods
/**********************************************************************/

- (void)setHttpOperationQueue:(NSOperationQueue *)httpOperationQueue{
    objc_setAssociatedObject(self, "core.network.httpOperationQueue", httpOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSOperationQueue *)httpOperationQueue{
    return objc_getAssociatedObject(self, "core.network.httpOperationQueue");
}

- (void)setHttpCompletionQueue:(dispatch_queue_t)httpCompletionQueue{
    objc_setAssociatedObject(self, "core.network.httpCompletionQueue", httpCompletionQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_queue_t)httpCompletionQueue{
    return objc_getAssociatedObject(self, "core.network.httpCompletionQueue");
}

- (void)setHttpCompletionGroup:(dispatch_group_t)httpCompletionGroup{
    objc_setAssociatedObject(self, "core.network.httpCompletionGroup", httpCompletionGroup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_group_t)httpCompletionGroup{
    return objc_getAssociatedObject(self, "core.network.httpCompletionGroup");
}

- (void)setHttpRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)httpRequestSerializer{
    objc_setAssociatedObject(self, "core.network.httpRequestSerializer", httpRequestSerializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)httpRequestSerializer{
    return objc_getAssociatedObject(self, "core.network.httpRequestSerializer");
}

- (void)setHttpResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)httpResponseSerializer{
    objc_setAssociatedObject(self, "core.network.httpResponseSerializer", httpResponseSerializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)httpResponseSerializer{
    return objc_getAssociatedObject(self, "core.network.httpResponseSerializer");
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

- (NSOperationQueue *)avaliableHttpOperationQueue{
    NSOperationQueue *httpOperationQueue = [self httpOperationQueue];
    if (httpOperationQueue == nil) {
        httpOperationQueue = [[NSOperationQueue alloc] init];
        [self setHttpOperationQueue:httpOperationQueue];
    }
    return httpOperationQueue;
}

- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)avaliableHttpRequestSerializer{
    AFHTTPRequestSerializer<AFURLRequestSerialization> *httpRequestSerializer = [self httpRequestSerializer];
    if (httpRequestSerializer == nil) {
        httpRequestSerializer = [AFJSONRequestSerializer serializer];
        httpRequestSerializer.stringEncoding = NSUTF8StringEncoding;
        httpRequestSerializer.HTTPShouldHandleCookies = YES;
        [self setHttpRequestSerializer:httpRequestSerializer];
    }
    return httpRequestSerializer;
}

- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)avaliableHttpResponseSerializer{
    AFHTTPResponseSerializer<AFURLResponseSerialization> *httpResponseSerializer = [self httpResponseSerializer];
    if (httpResponseSerializer == nil) {
        httpResponseSerializer = [AFHTTPResponseSerializer serializer];
        httpResponseSerializer.stringEncoding = NSUTF8StringEncoding;
        [self setHttpResponseSerializer:httpResponseSerializer];
    }
    return httpResponseSerializer;
}



//创建请求
- (AFHTTPRequestOperation *)createRequest:(NSString *)url method:(NSString *)method tag:(NSInteger)tag
                                   params:(void (^)(NSMutableDictionary *params))params
                                 bodyPart:(void (^)(id <AFMultipartFormData> formData))bodyPart
                                    error:(NSError *__autoreleasing *)error {
    
    NSMutableDictionary *parameters = nil;
    if (params) {
        parameters = [NSMutableDictionary dictionary];
        params(parameters);
    }
    NSError *tempError = nil;
    NSMutableURLRequest *request = nil;
    if (!IOS7_OR_LATER) {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    
    if (bodyPart) {
        request = [[self avaliableHttpRequestSerializer] multipartFormRequestWithMethod:method
                                                                              URLString:url
                                                                             parameters:parameters
                                                              constructingBodyWithBlock:bodyPart
                                                                                  error:&tempError];
    } else {
        request = [[self avaliableHttpRequestSerializer] requestWithMethod:method
                                                                 URLString:url
                                                                parameters:parameters
                                                                     error:&tempError];
    }
    if (tempError != nil) {
        DDLogVerbose(@"******************************请求开始(%@)******************************",@(tag));
        DDLogVerbose(@"请求地址:%@",url);
        DDLogVerbose(@"请求出错:%@", tempError.localizedDescription);
        DDLogVerbose(@"******************************请求完成(%@)******************************\n\n\n",@(tag));
        if (error) {
            *error = [NSError reqeustError:-1 message:tempError.localizedDescription];
        }
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.completionQueue = [self httpCompletionQueue];
    operation.completionGroup = [self httpCompletionGroup];
    operation.responseSerializer = [self avaliableHttpResponseSerializer];
    operation.userInfo = @{@"core.network.operation.tag": @(tag)};
    return operation;
}

//处理请求
- (void)handleRequest:(AFHTTPRequestOperation *)httpOperation
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDate *startDate = [NSDate date];
    NSNumber *tag = httpOperation.userInfo[@"core.network.operation.tag"];
    NSString *body = [[NSString alloc] initWithData:httpOperation.request.HTTPBody encoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    DDLogVerbose(@"******************************请求开始(%@)******************************",tag);
    DDLogVerbose(@"请求地址:%@",httpOperation.request.URL);
    DDLogVerbose(@"请求头信息:%@",httpOperation.request.allHTTPHeaderFields);
    DDLogVerbose(@"请求内容:%@",[body stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    [httpOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        DDLogVerbose(@"响应头信息:%@",operation.response.allHeaderFields);
        DDLogVerbose(@"响应内容:%@", operation.responseString);
        DDLogVerbose(@"请求用时:%f",[[NSDate date] timeIntervalSinceDate:startDate]);
        DDLogVerbose(@"******************************请求完成(%@)******************************\n\n\n",tag);
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        DDLogVerbose(@"响应头信息:%@",operation.response.allHeaderFields);
        DDLogVerbose(@"响应内容:%@", operation.responseString);
        DDLogVerbose(@"响应错误:%@", error.localizedDescription);
        DDLogVerbose(@"请求用时:%f",[[NSDate date] timeIntervalSinceDate:startDate]);
        DDLogVerbose(@"******************************请求完成(%@)******************************\n\n\n",tag);
        if (failure) {
            failure(operation, [NSError responseError:error.code message:error.errorMessage]);
        }
    }];
    //    [httpOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    //        NSLog(@"上传进度:%12lu%12lld%12lld%12.2f%%",(long)bytesWritten,totalBytesWritten,totalBytesExpectedToWrite,(double)totalBytesWritten/(double)totalBytesExpectedToWrite*100);
    //    }];
    //    [httpOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    //        NSLog(@"下载进度:%12lu%12lld%12lld%12.2f%%",(long)bytesRead,totalBytesRead,totalBytesExpectedToRead,(double)totalBytesRead/(double)totalBytesExpectedToRead*100);
    //    }];
}

/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/


//GET请求
- (AFHTTPRequestOperation *)GET:(NSString *)url tag:(NSInteger)tag
                         params:(void (^)(NSMutableDictionary *params))params
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSError *error = nil;
    
    AFHTTPRequestOperation *operation = [self createRequest:url method:@"GET" tag:tag params:params bodyPart:nil error:&error];
    if (error == nil) {
        [self handleRequest:operation success:success failure:failure];
        [[self avaliableHttpOperationQueue] addOperation:operation];
    } else {
        if (failure) {
            failure(operation,error);
        }
    }
    return operation;
}

//POST请求
- (AFHTTPRequestOperation *)POST:(NSString *)url tag:(NSInteger)tag
                          params:(void (^)(NSMutableDictionary *params))params
                        bodyPart:(void (^)(id <AFMultipartFormData> formData))bodyPart
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSError *error = nil;
    AFHTTPRequestOperation *operation = [self createRequest:url method:@"POST" tag:tag params:params bodyPart:bodyPart error:&error];
    if (error == nil) {
        [self handleRequest:operation success:success failure:failure];
        [[self avaliableHttpOperationQueue] addOperation:operation];
    } else {
        if (failure) {
            failure(operation,error);
        }
    }
    return operation;
}


//取消指定请求
- (void)cancelHttpRequest:(NSInteger)tag{
    NSOperationQueue *operationQueue = [self httpOperationQueue];
    if (operationQueue) {
        for (AFHTTPRequestOperation *operation in [operationQueue operations]) {
            id requestTag = [operation.userInfo objectForKey:@"core.network.operation.tag"];
            if (requestTag && [requestTag isEqualToNumber:@(tag)]) {
                [operation cancel];
            }
        }
    }
}

//取消所有请求
- (void)cancelAllHttpReqeust{
    NSOperationQueue *operationQueue = [self httpOperationQueue];
    if (operationQueue) {
        [operationQueue cancelAllOperations];
    }
}

@end
