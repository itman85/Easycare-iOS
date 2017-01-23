//
//  ECAppointment.m
//  EasyCare
//
//  Created by Chau luu on 12/30/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECAppointment.h"
#import "EasyCareApiClient.h"

@implementation ECAppointment
+ (ECAppointment *)appointmentWithDict:(NSDictionary *)dict
{
    
    ECAppointment *appointment = [ECAppointment new];
    appointment.appointment_id = NotNillValue([dict objectForKey:@"id"]);
    appointment.address = NotNillValue([dict objectForKey:@"address"]);
    appointment.addressID = NotNillValue([dict objectForKey:@"address_id"]);
    appointment.code = NotNillValue([dict objectForKey:@"code"]);
    appointment.created_at = [[DateFormatter sharedInstance] apiDateTimeFromString:NotNullValue(dict[@"created_at"])];
    appointment.doctor_id = NotNillValue([dict objectForKey:@"doctor_id"]);
    appointment.doctor_notes = NotNillValue([dict objectForKey:@"doctor_notes"]);
    appointment.examine_for = NotNillValue([dict objectForKey:@"examine_for"]);
    //    appointment.first_visit = [NotNillValue([dict objectForKey:@"first_visit"]) intValue];
    appointment.insurance = [NotNillValue([dict objectForKey:@"insurance"]) intValue];
    appointment.insurance_company = NotNillValue([dict objectForKey:@"insurance_company"]);
    
    NSDictionary *patientDict = NotNillValue([dict objectForKey:@"patient"]);
    if ([patientDict count] != 0) {
        appointment.patient = [ECPatient patientWithDictionary:patientDict];
    }
    
    appointment.patient_notes = NotNillValue([dict objectForKey:@"patient_notes"]);
    appointment.status = [NotNillValue([dict objectForKey:@"status"]) integerValue];
    appointment.time = [[DateFormatter sharedInstance] apiDateTimeFromString:NotNullValue(dict[@"time"])];
    NSString *reason = [NSString stringWithFormat:@"%@",[dict objectForKey:@"visit_reason"]];
    appointment.visit_reason = NotNillValue(reason);
    appointment.visits = [NotNillValue([dict objectForKey:@"visits"])  intValue];
    
    return appointment;
}

+ (RACSignal *)signalGetAppointmentsForPatient:(ECPatient *)patient
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex{
    
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetAppointmentsForPatient:patient withStatus:status date:date startDate:startDate endDate:endDate appointmentID:appointmentID pageIndex:pageIndex] subscribeNext:^(NSDictionary *responseDict) {
            
            NSArray *appoinmentsArray = [responseDict objectForKey:@"appointments"];
            NSMutableArray *appointments = [NSMutableArray array];
            for (NSDictionary *dict in appoinmentsArray) {
                
                ECAppointment *appointment = [ECAppointment appointmentWithDict:dict];
                [appointments addObject:appointment];
            }
            
            [subscriber sendNext:appointments];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}
+ (RACSignal *)signalGetAppointmentsForpatientName:(NSString *)patientName
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex{
    
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetAppointmentsForPatientName:patientName withStatus:status date:date startDate:startDate endDate:endDate appointmentID:appointmentID pageIndex:pageIndex] subscribeNext:^(NSDictionary *responseDict) {
            
            NSArray *appoinmentsArray = [responseDict objectForKey:@"appointments"];
            NSMutableArray *appointments = [NSMutableArray array];
            for (NSDictionary *dict in appoinmentsArray) {
                
                ECAppointment *appointment = [ECAppointment appointmentWithDict:dict];
                [appointments addObject:appointment];
            }
            
            [subscriber sendNext:appointments];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}

@end
