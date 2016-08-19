//
//  MSKMacro.h
//  MeiShiJ
//
//  Created by meishi.cc on 13-12-23.
//  Copyright (c) 2013年 MeiShiJ. All rights reserved.
//


#ifndef YWKMacro
#define YWKMacro

#define	PROPERTY_ASSIGN @property (nonatomic, assign)
#define	PROPERTY_ASSIGN_READONLY @property (nonatomic, assign, readonly)
#define	PROPERTY_COPY @property (nonatomic, copy)

#ifndef PROPERTY_STRONG
#if __has_feature(objc_arc)
    #define PROPERTY_STRONG @property(strong, nonatomic)
#else
    #define PROPERTY_STRONG @property(retain, nonatomic)
#endif
#endif

#ifndef PROPERTY_STRONG_READONLY
#if __has_feature(objc_arc)
    #define PROPERTY_STRONG_READONLY @property(strong, nonatomic, readonly)
#else
    #define PROPERTY_STRONG_READONLY @property(retain, nonatomic, readonly)
#endif
#endif

#ifndef PROPERTY_WEAK
#if __has_feature(objc_arc_weak)
    #define PROPERTY_WEAK @property(weak, nonatomic)
#elif __has_feature(objc_arc)
    #define PROPERTY_WEAK @property(unsafe_unretained, nonatomic)
#else
    #define PROPERTY_WEAK @property(assign, nonatomic)
#endif
#endif

#ifndef PROPERTY_WEAK_READONLY
#if __has_feature(objc_arc_weak)
    #define PROPERTY_WEAK_READONLY @property(weak, nonatomic, readonly)
#elif __has_feature(objc_arc)
    #define PROPERTY_WEAK_READONLY @property(unsafe_unretained, nonatomic, readonly)
#else
    #define PROPERTY_WEAK_READONLY @property(assign, nonatomic, readonly)
#endif
#endif


#ifndef __OPTIMIZE__
    # define NSLog(...) NSLog(__VA_ARGS__)
#else
    # define NSLog(...) {}
#endif


//frame
#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame
#define APP_CONTENT_WIDTH   (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT  (APP_SCREEN_BOUNDS.size.height - APP_STATUS_FRAME.size.height)

//SystemVersion -
#define DEVICE_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define NSVersionNumber_iOS_5_0 (DEVICE_SYSTEM_VERSION >= 5.0)
#define NSVersionNumber_iOS_6_0 (DEVICE_SYSTEM_VERSION >= 6.0)
#define NSVersionNumber_iOS_7_0 (DEVICE_SYSTEM_VERSION >= 7.0)
#define NSVersionNumber_iOS_8_0 (DEVICE_SYSTEM_VERSION >= 8.0)
#define NSVersionNumber_iOS_9_0 (DEVICE_SYSTEM_VERSION >= 9.0)

#define DEVICE_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  颜色
 */
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define YWWeak(var, weakVar) __weak __typeof(&*var) weakVar = var

#endif