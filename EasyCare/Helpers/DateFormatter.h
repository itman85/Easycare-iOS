/*============================================================================
 PROJECT: EasyCare
 FILE:    DateFormatter.h
 AUTHOR:  Vien Tran
 DATE:    12/31/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import <Foundation/Foundation.h>

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   DateFormatter
 =============================================================================*/

@interface DateFormatter : NSObject

+ (instancetype)sharedInstance;

- (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;
- (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

- (NSDate *)dateFromString:(NSString *)dateString;
- (NSString *)stringFromDate:(NSDate *)date;

- (NSDate *)dateTimeFromString:(NSString *)dateString;
- (NSString *)stringFromDateTime:(NSDate *)date;

- (NSDate *)apiDateFromString:(NSString *)dateString;
- (NSString *)apiStringFromDate:(NSDate *)date;

- (NSDate *)apiDateTimeFromString:(NSString *)dateString;
- (NSString *)apiStringFromDateTime:(NSDate *)date;

- (NSString *)timeStringFromDate:(NSDate *)date;
- (NSDate *)timeFromString:(NSString *)timeString;

- (NSDate *)apiTimeFromString:(NSString *)timeString;
- (NSString *)apiTimeStringFromDate:(NSDate *)date;

@end
