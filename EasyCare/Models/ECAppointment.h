//
//  ECAppointment.h
//  EasyCare
//
//  Created by Chau luu on 12/30/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECPatient.h"

@class ECPatient;
@interface ECAppointment : NSObject
@property(nonatomic)NSString *address;
@property(nonatomic)NSString *code;
@property(nonatomic)NSDate *created_at;
@property(nonatomic)NSString *doctor_id;
@property(nonatomic)NSString *doctor_notes;
@property(nonatomic)NSString *examine_for;
@property(nonatomic)int first_visit;
@property(nonatomic)NSString *appointment_id;
@property(nonatomic)int insurance;
@property(nonatomic)NSString *insurance_company;
@property(nonatomic)ECPatient *patient;
@property(nonatomic)NSString *patient_notes;
@property(nonatomic)NSInteger status;
@property(nonatomic)NSDate *time;
@property(nonatomic)NSString *visit_reason;
@property(nonatomic)NSString *addressID;
@property(nonatomic)int visits;

+ (ECAppointment *)appointmentWithDict:(NSDictionary *)dict;

+ (RACSignal *)signalGetAppointmentsForPatient:(ECPatient *)patient
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex;

+ (RACSignal *)signalGetAppointmentsForpatientName:(NSString *)patientName
                                        withStatus:(NSInteger)status
                                              date:(NSDate *)date
                                         startDate:(NSDate *)startDate
                                           endDate:(NSDate *)endDate
                                     appointmentID:(NSString *)appointmentID
                                         pageIndex:(NSInteger)pageIndex;

@end
