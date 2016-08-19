//
//  NSString+dataAdditions.m
//  Foodie
//
//  Created by liyunqi on 16/3/14.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "NSString+dataAdditions.h"

extern BOOL SYStringisEmpty(NSString *str)
{
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (str == nil) return YES;
    if ([str isKindOfClass:[NSNull class]]) return YES;
    if ([str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) return YES;
    if ([str isEqualToString:@""]) return YES;
    
    return NO;
}
@implementation NSString (dataAdditions)
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (!font) {
        NSLog(@"计算字体大小font=nil");
        return CGSizeZero;
        
    }
    if (SYStringisEmpty(text)) {
        return CGSizeZero;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        CGRect frame = [text boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        CGSize size = CGSizeMake((int)frame.size.width + 1, frame.size.height);
        
        return size;
    }
#endif
    return [text sizeWithFont:font constrainedToSize:size];
}




-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing
{
    
    
    return [self boundingRectWithSize:size withTextFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
{
    return [self attributedStringFromStingWithFont:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}


-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
                    alignment:(NSTextAlignment)alignment
{
    if (SYStringisEmpty(self)) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font
                                                                            lineSpacing:lineSpacing
                                                                              alignment:alignment];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    //    CGSize textSize=[self adjustSizeWithAttributedString:attributedText maxWidth:size.width numberLine:0];
    return textSize;
}

- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                     lineSpacing:(CGFloat)lineSpacing
                                                       alignment:(NSTextAlignment)alignment

{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:alignment];
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}
+(NSString *)Currentmillisecond
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",time];
}
+(NSString *)createDateStringyyyyMMdd
{
        NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
        [outputFormat setDateFormat:@"yyyyMMdd"];
        NSDate *date = [NSDate date];
        return [outputFormat stringFromDate:date];
}
@end
