/*============================================================================
 PROJECT: EasyCare
 FILE:    ECSchedule.m
 AUTHOR:  Vien Tran
 DATE:    12/31/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECSchedule.h"
#import "EasyCareApiClient.h"
#import "NSDate+Extensions.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation ECSchedule

+ (ECSchedule*)scheduleWithDictionary:(NSDictionary *)dict{
    ECSchedule *schedule = [ECSchedule new];

    schedule.scheduleID = NotNullValue(dict[@"id"]);
    schedule.date = [[DateFormatter sharedInstance] apiDateFromString:NotNullValue(dict[@"date"])];
    schedule.startTime = [[DateFormatter sharedInstance] apiTimeFromString:NotNullValue(dict[@"time_from"])];
    schedule.endTime = [[DateFormatter sharedInstance] apiTimeFromString:NotNullValue(dict[@"time_to"])];
    schedule.period = NotNullValue(dict[@"time_slots"]);
    schedule.addressID = NotNullValue(dict[@"doctor_address_id"]);
    schedule.note = NotNullValue(dict[@"note"]);

    return schedule;
}

- (id)copyWithZone:(NSZone *)zone{
    ECSchedule *copy = [ECSchedule new];
    
    if (copy) {
        copy.scheduleID = [self.scheduleID copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.period = [self.period copyWithZone:zone];
        copy.addressID = [self.addressID copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
    }
    
    return copy;
}

- (NSString *)validateMessage{
    if (!self.startTime) {
        return @"Bạn chưa nhập thời gian bắt đầu";
    }
    
    if (!self.endTime) {
        return @"Bạn chưa nhập thời gian kết thúc";
    }
    
    if ([self.startTime minutesBeforeDate:self.endTime] <= 0) {
        return @"Thời gian bắt đầu và kết thúc không hợp lệ";
    }
    
    if (!self.period || [self.period integerValue] <= 0) {
        return @"Bạn chưa nhập khoảng thời gian";
    }
    
    return nil;
}

+ (RACSignal*)signalGetSchedulesForDay:(NSDate*)date{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetSchedulesForDay:date] subscribeNext:^(NSDictionary *responseDict) {
            
            NSArray *schdedulesDict = responseDict[@"schedules"];
            NSMutableArray *schedules = [NSMutableArray arrayWithCapacity:schdedulesDict.count];
            for (NSDictionary *dict in schdedulesDict) {
                ECSchedule *schedule = [ECSchedule scheduleWithDictionary:dict];
                [schedules addObject:schedule];
            }
            
            [subscriber sendNext:schedules];
            
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}

- (RACSignal *)signalCreateOrUpdateSchedule{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *validateMessage = [self validateMessage];
        if (validateMessage) {
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey : validateMessage}];
            [subscriber sendError:error];
        }else{
            [[[EasyCareApiClient shared] signalCreateOrUpdateSchedule:self] subscribeNext:^(NSDictionary *responseDict) {
                [subscriber sendNext:self];
            } error:^(NSError *error) {
                [subscriber sendError:error];
            }];
        }
        
        return nil;
    }];
    
    return signal;
    
}


- (RACSignal *)signalDeleteSchedule{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalDeleteSchedule:self] subscribeNext:^(NSDictionary *responseDict) {
            [subscriber sendNext:self];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    return signal;
    
}

@end
