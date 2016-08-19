//
//  YWSearchModel.m
//  YQSearch
//
//  Created by yunqi on 16/8/14.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWSearchModel.h"

@implementation YWSearchModel
-(NSDictionary *)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"title",@"title",
            @"url",@"url",
            @"description",@"des",
            nil];
}
@end
