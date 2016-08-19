//
//  YWSearchNewModel.m
//  YQSearch
//
//  Created by yunqi on 16/8/14.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import "YWSearchNewModel.h"

@implementation YWSearchNewModel
-(NSDictionary *)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"title",@"title",
            @"link",@"link",
            @"source",@"source",
            nil];
}

@end
