#import "_User.h"

@interface User : _User {}

+ (User*)loggedUser;
+ (RACSignal *)signalLoginWithEmail:(NSString *)email password:(NSString *)password;

- (RACSignal *)signalLogout;

- (RACSignal *)signalGetStatistic;

- (RACSignal *)signalGetCommentsWithCurrentPage:(int)page;

- (RACSignal *)signalGetAppointmentsWithStatus:(int)status
                                      withPage:(int)page
                           withNumberOfRecords:(int)numberOfRecords;

- (RACSignal *)signalRejectAppointment:(NSString *)appointment_id;

- (RACSignal *)signalAcceptAppointment:(NSString *)appointment_id;

- (RACSignal *)signalUpdatNoteAppointment:(NSString *)appointment_id
                       withDoctorNotes:(NSString *)doctorNotes;

- (RACSignal *)signalSearchAppointmentswithStatus:(int)status
                              withAppointmentCode:(NSString *)code
                                    withStartDate:(NSString *)startdate
                                      withEndDate:(NSString *)endDate
                                         withPage:(int)page
                               withNumberOfRecord:(int)numberOfRecords
                                  withPatientName:(NSString *)patientName;

- (RACSignal *)signalUpdateAppointment:(NSString *)appointment_id
                              withDate:(NSString *)date
                              withTime:(NSString *)time withAddressID:(NSString *)addressID;
- (RACSignal *)signalRegisterNotificationWithTokenDevice:(NSString *)token;
@end
