//
//  YWSearchTitleModel.h
//  YQSearch
//
//  Created by yunqi on 16/8/14.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "YWSearchModel.h"
typedef enum
{
    YWSearchType_search,
    YWSearchType_new,
    YWSearchType_find
}YWSearchType;
@interface YWSearchTitleModel : YWBaseModel
PROPERTY_STRONG NSString *title;
PROPERTY_ASSIGN YWSearchType searchType;
PROPERTY_STRONG NSMutableArray *list;
@end
