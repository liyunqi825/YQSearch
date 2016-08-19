//
//  NSString+dataAdditions.h
//  Foodie
//
//  Created by liyunqi on 16/3/14.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
extern BOOL SYStringisEmpty(NSString *str);
@interface NSString (dataAdditions)
/**
 *  @brief 计算字符串size 方法
 *  @param  text text
 *  @param  font font
 *  @param  size 最大size
 *  @return  text
 *  @author 
 */
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing;

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;


-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
                    alignment:(NSTextAlignment)alignment;
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                     lineSpacing:(CGFloat)lineSpacing
                                                       alignment:(NSTextAlignment)alignment;
+(NSString *)Currentmillisecond;
+(NSString *)createDateStringyyyyMMdd;
@end
