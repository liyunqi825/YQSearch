//
//  YWSearchCell.h
//  YQSearch
//
//  Created by yunqi on 16/8/14.
//  Copyright © 2016年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWBaseModel.h"
@class YWSearchCell;
@protocol YWSearchCellDelegate<NSObject>
@optional
-(void)YWSearchCellFindClickIndex:(NSInteger)index cell:(YWSearchCell *)cell;
@end
@interface YWSearchCell : UITableViewCell
PROPERTY_WEAK id<YWSearchCellDelegate>delegate;
-(void)resetValue:(YWBaseModel *)model key:(NSString *)key fenci:(NSMutableArray *)listfenci;
+(float)heightWithModel:(YWBaseModel *)model;
@end
