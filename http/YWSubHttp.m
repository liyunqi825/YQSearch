//
//  YWSubHttp.m
//  YQSearch
//
//  Created by yunqi on 16/8/13.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWSubHttp.h"
#import "MSHttpRequest.h"
@interface YWSubHttp()
PROPERTY_STRONG MSHttpRequest *request;
PROPERTY_STRONG NSString *baseURL;
@end
@implementation YWSubHttp
+(YWSubHttp *)share
{
    static dispatch_once_t onceToken;
    static YWSubHttp *http=nil;
    dispatch_once(&onceToken, ^{
        http=[[YWSubHttp alloc]init];
    });
    return http;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseURL=@"http://www.16weiyou.com";
    }
    return self;
}
- (void)postRequestWithURL:(NSURL*)url
{
    self.request = [[MSHttpRequest alloc] initWithURL:url];
    [self.request setShouldContinueWhenAppEntersBackground:YES];
    [self.request setTimeOutSeconds:160];
    [self.request setStringEncoding:NSUTF8StringEncoding];
    
    [self.request setDelegate:self];
    [self.request setRequestMethod:@"GET"];
    
}

- (MSHttpRequest*)requestMethod:(NSString*)method paramWithKeyAndValue:(NSString*)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    NSString* urlPath = [NSString stringWithFormat:@"%@%@?&", self.baseURL, method];
    @autoreleasepool
    {
        if (firstObj) {
            id eachObj;
            NSString* eachKey;
            va_list argumentList;
            va_start(argumentList, firstObj);
            
            eachObj = firstObj;
            eachKey = va_arg(argumentList, id);
            
            while (eachObj != nil && eachKey != nil) {
                
                urlPath=[NSString stringWithFormat:@"%@%@=%@&",urlPath,eachObj,eachKey];
                eachObj = va_arg(argumentList, id);
                if (eachObj != nil) {
                    eachKey = va_arg(argumentList, id);
                }
            }
            va_end(argumentList);
        }
    }
    if([[urlPath substringFromIndex:urlPath.length-1] isEqualToString:@"&"] )
    {
        urlPath=[urlPath substringToIndex:urlPath.length-1];
    }
    NSLog(@"url:%@",urlPath);
    NSURL* url = [NSURL URLWithString:[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self postRequestWithURL:url];
    self.request.userInfo = [NSDictionary dictionaryWithObject:method forKey:@"requestKey"];
    
    return self.request;
}
-(id)dicValue:(NSData *)data
{
    id rValue=nil;
    if (data&&[data isKindOfClass:[NSData class]]) {
        rValue = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingMutableLeaves
                                                   error:nil];
    }
    return  rValue;

}
-(void)loadSerch:(NSString *)wd page:(NSInteger)page CompletionHandle:(void (^)(id responseDic))completionHandle
{
    NSString* tokenUrl = [NSString stringWithFormat:@"/wap/s/sapi.php"];
    __weak MSHttpRequest* request = [self requestMethod:tokenUrl
                                   paramWithKeyAndValue:@"token", @"weiabcdyou",@"wd",wd,@"p",[NSString stringWithFormat:@"%zi",page],@"type",@"2",
                                     nil];
    
    if (completionHandle) {
        [request setCompletionBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
        [request setFailedBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
    }
    [request startAsynchronous];

}
-(void)loadSerchNew:(NSString *)wd  CompletionHandle:(void (^)(id responseDic))completionHandle
{
    NSString* tokenUrl = [NSString stringWithFormat:@"/wap/s/zxapi.php"];
    __weak MSHttpRequest* request = [self requestMethod:tokenUrl
                                   paramWithKeyAndValue:@"token", @"weiabcdyou",@"wd",wd,
                                     nil];
    
    if (completionHandle) {
        [request setCompletionBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
        [request setFailedBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
    }
    [request startAsynchronous];
}
-(void)loadSearchFind:(NSString *)wd CompletionHandle:(void (^)(id responseDic))completionHandle
{
    NSString* tokenUrl = [NSString stringWithFormat:@"/wap/s/xzapi.php"];
    __weak MSHttpRequest* request = [self requestMethod:tokenUrl
                                   paramWithKeyAndValue:@"token", @"weiabcdyou",@"wd",wd,
                                     nil];
    
    if (completionHandle) {
        [request setCompletionBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
        [request setFailedBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
    }
    [request startAsynchronous];
}
-(void)loadFenCi:(NSString *)wd CompletionHandle:(void (^)(id responseDic))completionHandle
{

    NSString* tokenUrl = [NSString stringWithFormat:@"/wap/s/fcapi.php"];
    __weak MSHttpRequest* request = [self requestMethod:tokenUrl
                                   paramWithKeyAndValue:@"token", @"weiabcdyou",@"wd",wd,
                                     nil];
    
    if (completionHandle) {
        [request setCompletionBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
        [request setFailedBlock:^{
            completionHandle([self dicValue:request.responseData] );
        }];
    }
    [request startAsynchronous];

}
@end
