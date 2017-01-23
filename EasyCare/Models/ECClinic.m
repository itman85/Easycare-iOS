/*============================================================================
 PROJECT: EasyCare
 FILE:    ECClinic.m
 AUTHOR:  Vien Tran
 DATE:    12/31/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECClinic.h"
#import "EasyCareApiClient.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation ECClinic

+ (RACSignal *)signalGetClinics{
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetClinics] subscribeNext:^(NSDictionary *responseDict) {
            
            NSDictionary *clinicsDict = responseDict[@"addresses"];
            NSMutableArray *clinics = [NSMutableArray arrayWithCapacity:clinicsDict.allKeys.count];
            for (NSString *key in clinicsDict.allKeys) {
                ECClinic *clinic = [ECClinic new];
                clinic.clinicID = @([key integerValue]);
                clinic.address = clinicsDict[key];
                [clinics addObject:clinic];
            }
            
            [subscriber sendNext:clinics];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return [signal replayLazily];
}

@end
