//
//  NSMutableAttributedString+SYFont.h
//  Foodie
//
//  Created by liyunqi on 16/3/22.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@interface NSMutableAttributedString (SYFont)
- (void)setTextColor:(UIColor*)color;
- (void)setTextColor:(UIColor*)color range:(NSRange)range;
-(void)setTextColorWithAttName:(UIColor *)color range:(NSRange )range;

- (void)setFont:(UIFont*)font;
- (void)setFont:(UIFont*)font range:(NSRange)range;

- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier;
- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range;
-(void)setBackColor:(UIColor *)color range:(NSRange )range;

-(void)setDeleLine:(NSUnderlineStyle)style  range:(NSRange )range;
@end
