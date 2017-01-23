/*============================================================================
 PROJECT: EasyCare
 FILE:    ECSchedule.h
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
 Interface:   ECSchedule
 =============================================================================*/


@interface ECSchedule : NSObject <NSCopying>

@property (nonatomic) NSNumber *scheduleID;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSNumber *period;
@property (nonatomic) NSNumber *addressID;
@property (nonatomic) NSString *note;

+ (ECSchedule*)scheduleWithDictionary:(NSDictionary *)dict;

+ (RACSignal*)signalGetSchedulesForDay:(NSDate*)date;

- (RACSignal *)signalCreateOrUpdateSchedule;
- (RACSignal *)signalDeleteSchedule;

@end
