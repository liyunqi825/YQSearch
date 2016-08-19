//
//  MSBaseModelObject.m
//  meishi
//
//  Created by jerry on 15/3/19.
//  Copyright (c) 2015年 Kangbo. All rights reserved.
//

#import "MSBaseModelObject.h"
#import <objc/runtime.h>
@implementation MSBaseModelObject
-(NSString *)autoAddModel:(NSString *)key
{
    return  [NSString stringWithFormat:@"%@%@",key,MSBaseAutomaticInterpretation];
}
-(NSString *)autoAddModelList:(NSString *)key className:(Class)classValue
{
    if (classValue) {
       return  [NSString stringWithFormat:@"%@%@%@",key,MSBaseAutomaticInterpretationList,NSStringFromClass(classValue)];
    }
    return key;
}
-(id)init
{
    self=[super init];
    if (self) {
        _msCan_ding=YES;
        _msCan_cai=YES;
    }
    return self;
}
-(id)initWithDataDic:(NSDictionary*)data{
    if (self = [super init]) {
        _msCan_ding=YES;
        _msCan_cai=YES;
        [self setAttributes:data];
    }
    return self;
}
-(NSDictionary*)attributeMapDictionary{
    return nil;
}
-(SEL)setSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
    return nil;
}

//- (NSString *)description{
//    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:0];
//    NSDictionary *attrMapDic = [self attributeMapDictionary];
//    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
//    id attributeName;
//    
//    while ((attributeName = [keyEnum nextObject])) {
//        SEL getSel = NSSelectorFromString(attributeName);
//        if ([self respondsToSelector:getSel]) {
//            NSMethodSignature *signature = nil;
//            signature = [self methodSignatureForSelector:getSel];
//            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//            [invocation setTarget:self];
//            [invocation setSelector:getSel];
//            NSObject *valueObj = nil;
//            [invocation invoke];
//            [invocation getReturnValue:&valueObj];
//            if (valueObj) {
//                [attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];
//                //[valueObj release];
//            }else {
//                [attrsDesc appendFormat:@" [%@=nil] ",attributeName];
//            }
//            
//        }
//    }
//    
//    NSString *customDesc = [self customDescription];
//    NSString *desc;
//    
//    if (customDesc && [customDesc length] > 0 ) {
//        desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
//    }else {
//        desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
//    }
//    
//    return desc;
//    return @"";
//}

-(char *)getPropertyType:(NSString *)attributeName
{
    objc_property_t number_property = class_getProperty([self class], [attributeName cStringUsingEncoding:NSASCIIStringEncoding]);
    char *number_property_type_attribute = property_copyAttributeValue(number_property, "T");
    return number_property_type_attribute;
}
-(Class)classWithProperty:(char *)property
{
    Class class = nil;
    if (strlen(property) >= 3) {
        char *className = strndup(property+2, strlen(property)-3);
        class = NSClassFromString([NSString stringWithUTF8String:className]);
    }
    return class;
}
-(Class)classWithattributeName:(NSString *)attributeName
{
    char *propertyType=[self getPropertyType:attributeName];
    Class class=[self classWithProperty:propertyType];
    return class;
}
-(BOOL)hax:(NSString *)sourse str:(NSString *)str
{
    if ([sourse rangeOfString:str].length) {
        return YES;
    }
    return NO;
}
-(id)valueForString:(id)value
{
    if (!value) {
        return value;
    }
    if ([value isKindOfClass:[NSNull class]]) {
        return value=nil;
    }
//    if ([value isKindOfClass:[NSNumber class]]) {
    if (![value isKindOfClass:[NSString class]] && ![value isKindOfClass:[NSArray class]]) {
//        value=[value stringValue];
        
        value=[NSString stringWithFormat:@"%@",value];
    }
//    }
    return value;
}
-(void)setAttributes:(NSDictionary*)dataDic{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil||![attrMapDic isKindOfClass:[NSDictionary class]]||![dataDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL sel = [self getSetterSelWithAttibuteName:attributeName];
        if ([self respondsToSelector:sel]) {
            NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id value=[dataDic objectForKey:dataDicKey];
            if ([value isKindOfClass:[NSNull class]]) {
                value=nil;
            }

            if ([self hax:dataDicKey str:MSBaseAutomaticInterpretation]) {
                Class class=[self classWithattributeName:attributeName];
                if ([class isSubclassOfClass:[self.class superclass]]) {
                    value=[dataDic objectForKey:[dataDicKey stringByReplacingOccurrencesOfString:MSBaseAutomaticInterpretation withString:@""]];
                    if ([value isKindOfClass:[NSNull class]]) {
                        value=nil;
                    }
                    value=[[class alloc]initWithDataDic:value];
                }
            }else if([self hax:dataDicKey str:MSBaseAutomaticInterpretationList])
            {
                Class class=[self classWithattributeName:attributeName];
                NSString *classListStr=[dataDicKey componentsSeparatedByString:MSBaseAutomaticInterpretationList].count>1?[[dataDicKey componentsSeparatedByString:MSBaseAutomaticInterpretationList]objectAtIndex:1]:nil;
                Class classList=NSClassFromString(classListStr);
                if ([class isSubclassOfClass:[NSArray class]]&&[classList isSubclassOfClass:[self.class superclass]]) {
                    NSString *attkey=[dataDicKey componentsSeparatedByString:MSBaseAutomaticInterpretationList].count?[[dataDicKey componentsSeparatedByString:MSBaseAutomaticInterpretationList]objectAtIndex:0]:nil;
                    value=[dataDic objectForKey:attkey];
                    if ([value isKindOfClass:[NSNull class]]||![value isKindOfClass:[NSArray class]]) {
                        value=nil;
                    }
                    NSMutableArray *list=[NSMutableArray array];
                    for (NSDictionary *dic in value) {
                        if ([dic isKindOfClass:[NSDictionary class]]) {
                            [list addObject:[[classList alloc]initWithDataDic:dic]];
                        }else
                        {
                            
                            NSLog(@"BaseModel Error:%@----%@ 类型不对",NSStringFromClass([self class]),NSStringFromClass([classList class]));
                        }
                    }
//                    if (list.count) {
                        value=list;
//                    }
                }
            }else
            {
                value=[self valueForString:value];
            }
            [self performSelectorOnMainThread:sel
                                    withObject:value
                                 waitUntilDone:[NSThread isMainThread]];
           
           
        }
    }
}
- (id)initWithCoder:(NSCoder *)decoder{
    if( self = [super init] ){
        NSDictionary *attrMapDic = [self attributeMapDictionary];
        if (attrMapDic == nil) {
            return self;
        }
        NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
        id attributeName;
        while ((attributeName = [keyEnum nextObject])) {
            SEL sel = [self getSetterSelWithAttibuteName:attributeName];
            if ([self respondsToSelector:sel]) {
                id obj = [decoder decodeObjectForKey:attributeName];
                [self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        return;
    }
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            
            if (valueObj) {
                
                [encoder encodeObject:valueObj forKey:attributeName];	
            }
        }
    }
}
- (NSData*)getArchivedData{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}


//copy set
- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
- (id)copyWithZone:(NSZone *)zone
{
    MSBaseModelObject *copyModel=[[self.class alloc]init];
    NSDictionary *allPropertiesAndValue=[self getAllPropertiesAndVaules];
    for (int i=0; i<allPropertiesAndValue.allKeys.count; i++) {
        id attributeName=[allPropertiesAndValue.allKeys objectAtIndex:i];
        
        SEL getSel = NSSelectorFromString(attributeName);
        SEL setSel=[self getSetterSelWithAttibuteName:attributeName];
        
        if ([self  respondsToSelector:getSel]) {
            id subProperties=[self performSelector:getSel];
            id subPropertiesValue=[allPropertiesAndValue objectForKey:attributeName];
            
            if ([copyModel respondsToSelector:setSel]) {
                if ([[subProperties class] isSubclassOfClass:[MSBaseModelObject class]]) {
                    [copyModel performSelectorOnMainThread:setSel withObject:[subPropertiesValue copy] waitUntilDone:[NSThread isMainThread]];
                }else
                {
                    [copyModel performSelectorOnMainThread:setSel withObject:subPropertiesValue  waitUntilDone:[NSThread isMainThread]];
                }
            }
            
        }
    }
    return copyModel;
}
-(BOOL)subPropertiesValueCanAdd:(id)subProperties
{
    BOOL can=YES;
    if ([[subProperties class] isSubclassOfClass:[MSBaseModelObject class]]) {
        can=NO;
    }
    if ([subProperties isKindOfClass:[NSArray class]]) {
        can=NO;
    }
    return can;
}
-(NSString *)jsonValue
{
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionary];
    NSDictionary *allPropertiesAndValue=[self getAllPropertiesAndVaules];
    NSDictionary *mapDic=[self attributeMapDictionary];
    for (int i=0; i<allPropertiesAndValue.allKeys.count; i++) {
        id attributeName=[allPropertiesAndValue.allKeys objectAtIndex:i];
        NSString *keyName=[mapDic objectForKey:attributeName];
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self  respondsToSelector:getSel]&&keyName) {
            id subProperties=[self performSelector:getSel];
            id subPropertiesValue=[allPropertiesAndValue objectForKey:attributeName];
            if (![self subPropertiesValueCanAdd:subProperties]) {
//                [dicValue setObject:[subProperties jsonValue] forKey:attributeName];
            }else
            {
                subPropertiesValue=[self valueForString:subPropertiesValue];
                [dicValue setObject:subPropertiesValue forKey:keyName];
            }
        }
    }
    return nil;
//    return [dicValue JSONRepresentation];
}

@end
