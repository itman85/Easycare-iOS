/*============================================================================
 PROJECT: EasyCare
 FILE:    Patient.m
 AUTHOR:  Vien Tran
 DATE:    12/24/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatient.h"
#import "EasyCareApiClient.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation ECPatient

+ (ECPatient*)patientWithDictionary:(NSDictionary *)dict{
    ECPatient *patient = [ECPatient new];
    
    patient.patientID = NotNullValue(dict[@"id"]);
    patient.fullName = NotNullValue(dict[@"full_name"]);
    patient.birthday = NotNullValue(dict[@"birthday"]);
    patient.address = NotNullValue(dict[@"address"]);
    patient.avatarUrl = NotNullValue(dict[@"avatar"]);
    patient.avatarThumbUrl = NotNullValue(dict[@"avatar_thumb"]);
    patient.email = NotNullValue(dict[@"email"]);
    patient.phoneNumber = NotNullValue(dict[@"phone"]);
    patient.gender = [NotNullValue(dict[@"gender"]) boolValue];
    
    patient.visitsCount = NotNullValue(dict[@"visits"]);
    patient.cancelVisitsCount = NotNullValue(dict[@"cancelVisits"]);
    patient.commentCount = NotNullValue(dict[@"totalComment"]);
    patient.changeAppointmentCount = NotNullValue(dict[@"numberChangeAppointment"]);
    
    return patient;
}


+ (RACSignal *)signalGetPatientsWithBanned:(BOOL)banned pageIndex:(NSInteger)pageIndex{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetPatientsWithBanned:banned pageIndex:pageIndex] subscribeNext:^(NSDictionary *responseDict) {
            
            NSArray *patientsDict = responseDict[@"patients"];
            NSMutableArray *patients = [NSMutableArray arrayWithCapacity:patientsDict.count];
            for (NSDictionary *dict in patientsDict) {
                ECPatient *patient = [ECPatient patientWithDictionary:dict];
                [patients addObject:patient];
            }
            
            [subscriber sendNext:patients];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return [signal replayLazily];
}

- (RACSignal *)signalBan{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalBanPatientWithID:self.patientID] subscribeNext:^(NSDictionary *responseDict) {
            [subscriber sendNext:responseDict];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}

- (RACSignal *)signalUnban{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalUnbanPatientWithID:self.patientID] subscribeNext:^(NSDictionary *responseDict) {
            
            [subscriber sendNext:responseDict];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}

@end
