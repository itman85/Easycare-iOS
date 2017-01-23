/*============================================================================
 PROJECT: EasyCare
 FILE:    EasyCareApiClient.h
 AUTHOR:  Vien Tran
 DATE:    12/22/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BaseApiClient.h"

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   EasyCareApiClient
 =============================================================================*/

@class ECSchedule, ECPatient;
@interface EasyCareApiClient : BaseApiClient

+ (instancetype)shared;

//For user
- (RACSignal *)signalLoginWithEmail:(NSString *)email password:(NSString *)password;
- (RACSignal *)signalLogoutWithToken:(NSString *)token;

//For patient
- (RACSignal *)signalGetPatientsWithBanned:(BOOL)banned pageIndex:(NSInteger)pageIndex;
- (RACSignal *)signalBanPatientWithID:(NSNumber*)patientID;
- (RACSignal *)signalUnbanPatientWithID:(NSNumber*)patientID;

//For calendar
- (RACSignal *)signalGetSchedulesForDay:(NSDate *)date;
- (RACSignal *)signalCreateOrUpdateSchedule:(ECSchedule *)schedule;
- (RACSignal *)signalDeleteSchedule:(ECSchedule *)schedule;
- (RACSignal *)signalGetClinics;

// For statictis
- (RACSignal *)signalGetStatictis:(NSString *)token;

// For comments
- (RACSignal *)signalGetCommentsWithToken:(NSString *)token withCurrentPage:(int)page;

// For Appointments
- (RACSignal *)signalGetAppointmentsForPatient:(ECPatient *)patient
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex;

- (RACSignal *)signalGetAppointmentsForPatientName:(NSString *)patientName
                                        withStatus:(NSInteger)status
                                              date:(NSDate *)date
                                         startDate:(NSDate *)startDate
                                           endDate:(NSDate *)endDate
                                     appointmentID:(NSString *)appointmentID
                                         pageIndex:(NSInteger)pageIndex;


- (RACSignal *)signalGetAppointmentsWithToken:(NSString *)token
                                   withStatus:(int)status
                                     withPage:(int)page
                           withNumberOfRecord:(int)numberOfRecord;

- (RACSignal *)signalSearchAppointmentsWithToken:(NSString *)token
                                      withStatus:(int)status
                             withAppointmentCode:(NSString *)code
                                   withStartDate:(NSString *)startdate
                                     withEndDate:(NSString *)endDate
                                        withPage:(int)page
                              withNumberOfRecord:(int)numberOfRecord
                                 withPatientName:(NSString *)patientName;

- (RACSignal *)signalRejectAppointment:(NSString *)token
                     withAppointmentID:(NSString *)appointment_id;

- (RACSignal *)signalAcceptAppointment:(NSString *)token
                     withAppointmentID:(NSString *)appointment_id;

- (RACSignal *)signalAppointmentAddDoctorNotes:(NSString *)token
                             withAppointmentID:(NSString *)appointment_id
                                withDoctorNote:(NSString *)doctor_notes;
- (RACSignal *)signalUpdateAppointmentWithToken:(NSString *)token
                              withAppointmentID:(NSString *)appointment_id
                                       withDate:(NSString *)date
                                       withTime:(NSString *)time withAddressId:(NSString *)addressID;

- (RACSignal *)signaRegisterPushNotificationWithTokenDevice:(NSString *)tokenDevice WithTokenUser:(NSString *)tokenUser;
@end
