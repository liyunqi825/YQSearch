//
//  YWSubHttp.h
//  YQSearch
//
//  Created by yunqi on 16/8/13.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YWSubHttp : NSObject
+(YWSubHttp *)share;
-(void)loadSerch:(NSString *)wd page:(NSInteger)page CompletionHandle:(void (^)(id responseDic))completionHandle;
-(void)loadSerchNew:(NSString *)wd  CompletionHandle:(void (^)(id responseDic))completionHandle;
-(void)loadSearchFind:(NSString *)wd CompletionHandle:(void (^)(id responseDic))completionHandle;
@end
