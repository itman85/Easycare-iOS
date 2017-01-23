//
//  Macros.h
//  EasyCare
//
//  Created by Vien Tran on 12/12/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#ifndef EasyCare_Macros_h
#define EasyCare_Macros_h

#import "AppDelegate.h"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define NotNullValue(a) (!a || a == (id)[NSNull null] ? nil : a)
#define NotNillValue(a) (!a) ? @"" : a

#define COLOR_RGB(r, g, b)                            \
    [UIColor colorWithRed:(CGFloat)r / (CGFloat)255.0 \
                    green:(CGFloat)g / (CGFloat)255.0 \
                    blue:(CGFloat)b / (CGFloat)255.0 \
                    alpha:(CGFloat)1.0]

#define COLOR_RGB_A(r, g, b, a)                       \
    [UIColor colorWithRed:(CGFloat)r / (CGFloat)255.0 \
                    green:(CGFloat)g / (CGFloat)255.0 \
                    blue:(CGFloat)b / (CGFloat)255.0 \
                    alpha:(CGFloat)a]

#define UIColorFromHexaRGB(rgbValue) UIColorFromHexaRGBA(rgbValue, 1.0)

#define UIColorFromHexaRGBA(rgbValue, a)                                 \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                    blue:((float)(rgbValue & 0xFF)) / 255.0             \
                    alpha:a]

//Notification
#define NotifCenter                     [NSNotificationCenter defaultCenter]

#define NotifReg(o,s,n)                 [NotifCenter addObserver:o selector:s name:n object:nil]
#define NotifRegMe(o,s,n)               [NotifCenter addObserver:o selector:s name:n object:o]
#define NotifUnreg(o,n)                 [NotifCenter removeObserver:o name:n object:nil]
#define NotifUnregAll(o)                [NotifCenter removeObserver:o]

#define NotifPost2Obj4Info(n,o,i)       [NotifCenter postNotificationName:n object:o userInfo:i]
#define NotifPost2Obj(n,o)               NotifPost2Obj4Info(n,o,nil)
#define NotifPost(n)                     NotifPost2Obj(n,nil)

#define NotifPostNotif(n)               [NotifCenter postNotification:n]


//Fonts
#define FontWithSize(d)                      [UIFont systemFontOfSize:d]
#define FontBoldWithSize(d)                  [UIFont boldSystemFontOfSize:d]

#define FontRobotoWithSize(d)                [UIFont fontWithName:@"Roboto-Regular" size:d]
#define FontRobotoItalicWithSize(d)          [UIFont fontWithName:@"Roboto-Italic" size:d]
#define FontRobotoMediumWithSize(d)          [UIFont fontWithName:@"Roboto-Medium" size:d]

#define FontRobotoLightWithSize(d)           [UIFont fontWithName:@"Roboto-Light" size:d]
#define FontRobotoLightItalicWithSize(d)     [UIFont fontWithName:@"Roboto-LightItalic" size:d]

#define FontRobotoBoldWithSize(d)            [UIFont fontWithName:@"Roboto-Bold" size:d]
#define FontRobotoBoldItalicWithSize(d)      [UIFont fontWithName:@"Roboto-BoldItalic" size:d]

#define CANCEL_APPOINMENT_STATUS -1
#define WAITTING_APPOINTMENT_STATUS 0
#define ACCEPTED_APPOINTMENT_STATUS 1
#define NUMBER_OF_RECORDS 10

// define Star image name
#define YELLOW_STAR_NAME @"icon_yellow_star.png"
#define GRAY_STAR_NAME   @"icon_gray_star.png"


#endif
