//
//  MSBaseModelObject.h
//  meishi
//
//  Created by jerry on 15/3/19.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

//多层嵌套时 copy 和序列化 尚未处理
#define MSBaseAutomaticInterpretation @"*MSBaseAutomaticInterpretation&"
#define MSBaseAutomaticInterpretationList @"*MSBaseAutomaticInterpretationList&"
@interface MSBaseModelObject : NSObject
PROPERTY_ASSIGN BOOL msCan_ding;
PROPERTY_ASSIGN BOOL msCan_cai;
-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;
-(NSString *)autoAddModel:(NSString *)key;
-(NSString *)autoAddModelList:(NSString *)key className:(Class)classValue;
-(NSString *)jsonValue;
@end
