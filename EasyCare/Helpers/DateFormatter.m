/*============================================================================
 PROJECT: EasyCare
 FILE:    DateFormatter.m
 AUTHOR:  Vien Tran
 DATE:    12/31/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "DateFormatter.h"
#import "NSDate+Extensions.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
static NSString *const DEFAULT_DATE_FORMATTER = @"dd/MM/yyyy";
static NSString *const DEFAULT_DATE_TIME_FORMATTER = @"dd/MM/yyyy, HH:mm";
static NSString *const API_DATA_DATE_FORMATTER = @"yyyy-MM-dd";
static NSString *const API_DATA_DATE_TIME_FORMATTER = @"yyyy-MM-dd HH:mm:ss";
static NSString *const TIME_FORMATTER = @"HH:mm";
static NSString *const API_DATA_RESPONSE_TIME_FORMATTER = @"HH:mm:ss";
static NSString *const API_DATA_REQUEST_TIME_FORMATTER = @"HH:mm";
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface DateFormatter ()

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation DateFormatter

+ (instancetype)sharedInstance{
    static DateFormatter *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DateFormatter alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init{
    if ((self = [super init])) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:DEFAULT_DATE_FORMATTER];
        [self.dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"VI"]];
        [self.dateFormatter setAMSymbol:[self.dateFormatter.AMSymbol lowercaseString]];
        [self.dateFormatter setPMSymbol:[self.dateFormatter.PMSymbol lowercaseString]];
    }
    
    return self;
}

- (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format{
    if (dateString.length == 0) {
        return nil;
    }

    [self.dateFormatter setDateFormat:format];
    NSDate *selected = [self.dateFormatter dateFromString:dateString];
    return selected;
}

- (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateFormat:format];
    NSString *stringDate = [self.dateFormatter stringFromDate:date];
    return stringDate;
}

- (NSDate *)dateFromString:(NSString *)dateString{
    return [self dateFromString:dateString withFormat:DEFAULT_DATE_FORMATTER];
}

- (NSString *)stringFromDate:(NSDate *)date{
    return [self stringFromDate:date withFormat:DEFAULT_DATE_FORMATTER];
}

- (NSDate *)dateTimeFromString:(NSString *)dateString{
    return [self dateFromString:dateString withFormat:DEFAULT_DATE_TIME_FORMATTER];
}

- (NSString *)stringFromDateTime:(NSDate *)date{
    return [self stringFromDate:date withFormat:DEFAULT_DATE_TIME_FORMATTER];
}

- (NSDate *)apiDateFromString:(NSString *)dateString{
    return [self dateFromString:dateString withFormat:API_DATA_DATE_FORMATTER];
}

- (NSString *)apiStringFromDate:(NSDate *)date{
    return [self stringFromDate:date withFormat:API_DATA_DATE_FORMATTER];
}

- (NSDate *)apiDateTimeFromString:(NSString *)dateString{
    return [self dateFromString:dateString withFormat:API_DATA_DATE_TIME_FORMATTER];
}

- (NSString *)apiStringFromDateTime:(NSDate *)date{
    return [self stringFromDate:date withFormat:API_DATA_DATE_TIME_FORMATTER];
}

- (NSString *)timeStringFromDate:(NSDate *)date{
    return [self stringFromDate:date withFormat:TIME_FORMATTER];
}

- (NSDate *)timeFromString:(NSString *)timeString{
    return [self dateFromString:timeString withFormat:TIME_FORMATTER];
}

- (NSDate *)apiTimeFromString:(NSString *)timeString{
    NSDate *time = [self dateFromString:timeString withFormat:API_DATA_RESPONSE_TIME_FORMATTER];
    return [time dateBySubtractingSeconds:time.seconds];
}

- (NSString *)apiTimeStringFromDate:(NSDate *)date{
    return [self stringFromDate:[date dateBySubtractingSeconds:date.seconds] withFormat:API_DATA_REQUEST_TIME_FORMATTER];
}

@end
