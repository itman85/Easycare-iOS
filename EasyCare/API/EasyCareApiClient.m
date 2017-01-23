/*============================================================================
 PROJECT: EasyCare
 FILE:    EasyCareApiClient.m
 AUTHOR:  Vien Tran
 DATE:    12/22/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "EasyCareApiClient.h"
#import "User.h"
#import "ECSchedule.h"
#import "ECPatient.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation EasyCareApiClient

+ (instancetype)shared{
    static EasyCareApiClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EasyCareApiClient alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
        [sharedInstance setRequestSerializer:[AFHTTPRequestSerializer serializer]];
//        [sharedInstance setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];

        responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 202)];
        [sharedInstance setResponseSerializer:responseSerializer];
    });
    
    return sharedInstance;
}

#pragma mark - Private methods
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters{
    NSString *urlString = [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:urlString parameters:parameters error:nil];
    
    return request;
}

- (NSMutableDictionary *)inputParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    User *loggedUser = [User loggedUser];
    if (loggedUser) {
        [params setObject:loggedUser.token forKey:@"token"];
    }
    return params;
}

#pragma mark - Public methods

#pragma mark - Login
- (RACSignal *)signalLoginWithEmail:(NSString *)email password:(NSString *)password{
    NSString *path = @"users/login";
    NSDictionary *params = @{@"email" : email,
                             @"password" : password};
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:path parameters:params]];
}

- (RACSignal *)signalLogoutWithToken:(NSString *)token{
    NSString *path = @"users/logout";
    NSDictionary *params = [self inputParams];
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:path parameters:params]];
}

#pragma mark - Patients
- (RACSignal *)signalGetPatientsWithBanned:(BOOL)banned pageIndex:(NSInteger)pageIndex{
    NSString *path = @"doctors/patients";
    
    NSMutableDictionary *params = [self inputParams];
    [params setObject:@(banned) forKey:@"is_banned"];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@(NUMBER_OF_RECORDS) forKey:@"numberOfRecords"];
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:path parameters:params]];
}

- (RACSignal *)signalBanPatientWithID:(NSNumber*)patientID{
    NSString *path = @"doctors/patients/ban";
    
    NSMutableDictionary *params = [self inputParams];
    [params setObject:patientID forKey:@"id"];
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:path parameters:params]];
}

- (RACSignal *)signalUnbanPatientWithID:(NSNumber*)patientID{
    NSString *path = @"doctors/patients/not_ban";
    
    NSMutableDictionary *params = [self inputParams];
    [params setObject:patientID forKey:@"id"];
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:path parameters:params]];
}

#pragma mark - Calendar
- (RACSignal *)signalGetSchedulesForDay:(NSDate *)date{
    NSString *path = @"doctors/schedules";
    NSMutableDictionary *params = [self inputParams];
    [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:date] forKey:@"date"];
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:path parameters:params]];
}

- (RACSignal *)signalCreateOrUpdateSchedule:(ECSchedule *)schedule{
    
    NSString *path;
    NSMutableDictionary *params = [self inputParams];
    [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:schedule.date] forKey:@"date"];
    [params setObject:[[DateFormatter sharedInstance] apiTimeStringFromDate:schedule.startTime] forKey:@"time_from"];
    [params setObject:[[DateFormatter sharedInstance] apiTimeStringFromDate:schedule.endTime] forKey:@"time_to"];
    [params setObject:schedule.period forKey:@"time_slots"];
    [params setObject:schedule.addressID forKey:@"doctor_address_id"];
    [params setObject:schedule.note forKey:@"note"];
    
    if (schedule.scheduleID) {
        path = @"doctors/schedules/update";
        [params setObject:schedule.scheduleID forKey:@"id"];
    }else{
        path = @"doctors/schedules/create";
    }
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:path parameters:params]];
}

- (RACSignal *)signalDeleteSchedule:(ECSchedule *)schedule{
    
    NSString *path = @"doctors/schedules/delete";
    NSMutableDictionary *params = [self inputParams];
    [params setObject:schedule.scheduleID forKey:@"id"];

    return [self enqueueRequest:[self requestWithMethod:@"DELETE" path:path parameters:params]];
}

- (RACSignal *)signalGetClinics{
    NSString *path = @"doctors/addresses";
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:path parameters:[self inputParams]]];
}

#pragma mark - Statictis
- (RACSignal *)signalGetStatictis:(NSString *)token
{
    NSDictionary *params = @{@"token" : token};
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_STATISTIC parameters:params]];
}

#pragma mark - Comments

- (RACSignal *)signalGetCommentsWithToken:(NSString *)token withCurrentPage:(int)page
{
    NSDictionary *params = @{@"token" : token,
                             @"page" :@(page),
                             @"numberOfRecords" : @(NUMBER_OF_RECORDS)
                             };

    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_COMMENTS parameters:params]];
}

#pragma mark - Appointments
- (RACSignal *)signalGetAppointmentsForPatient:(ECPatient *)patient
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex{
    NSMutableDictionary *params = [self inputParams];
    [params setObject:@(status) forKey:@"appointmentStatus"];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@(NUMBER_OF_RECORDS) forKey:@"numberOfRecords"];
    
    if (patient) {
        [params setObject:patient.patientID forKey:@"patientId"];
    }
    
    if (appointmentID) {
        [params setObject:appointmentID forKey:@"appointmentCode"];
    }
    
    if (date) {
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:date] forKey:@"appointmentDate"];
    }else if (startDate && endDate){
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:startDate] forKey:@"startDate"];
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:endDate] forKey:@"endDate"];
    }
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_APPOINTMENTS parameters:params]];
}

- (RACSignal *)signalGetAppointmentsForPatientName:(NSString *)patientName
                                    withStatus:(NSInteger)status
                                          date:(NSDate *)date
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                 appointmentID:(NSString *)appointmentID
                                     pageIndex:(NSInteger)pageIndex{
    NSMutableDictionary *params = [self inputParams];
    [params setObject:@(status) forKey:@"appointmentStatus"];
    [params setObject:@(pageIndex) forKey:@"page"];
    [params setObject:@(NUMBER_OF_RECORDS) forKey:@"numberOfRecords"];
    
    if ([patientName length] != 0) {
        [params setObject:patientName forKey:@"patientName"];
    }
    
    if (appointmentID) {
        [params setObject:appointmentID forKey:@"appointmentCode"];
    }
    
    if (date) {
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:date] forKey:@"appointmentDate"];
    }else if (startDate && endDate){
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:startDate] forKey:@"startDate"];
        [params setObject:[[DateFormatter sharedInstance] apiStringFromDate:endDate] forKey:@"endDate"];
    }
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_APPOINTMENTS parameters:params]];
}

- (RACSignal *)signalGetAppointmentsWithToken:(NSString *)token
                                   withStatus:(int)status
                                     withPage:(int)page
                           withNumberOfRecord:(int)numberOfRecord
{
    NSDictionary *params = @{@"token" : token,
                             @"appointmentStatus": @(status),
                             @"page":@(page),
                             @"numberOfRecords":@(numberOfRecord)};
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_APPOINTMENTS parameters:params]];
}
- (RACSignal *)signalSearchAppointmentsWithToken:(NSString *)token
                                      withStatus:(int)status
                             withAppointmentCode:(NSString *)code
                                   withStartDate:(NSString *)startdate
                                     withEndDate:(NSString *)endDate
                                        withPage:(int)page
                              withNumberOfRecord:(int)numberOfRecord
                                 withPatientName:(NSString *)patientName
{
    NSDictionary *params = @{@"token" : token,
                             @"appointmentStatus" : @(status),
                             @"appointmentCode" : NotNillValue(code),
                             @"startDate" : NotNillValue(startdate),
                             @"endDate" : NotNillValue(endDate),
                             @"page" : @(page),
                             @"numberOfRecords":@(numberOfRecord),
                             @"patientName":NotNillValue(patientName)};
    
    return [self enqueueRequest:[self requestWithMethod:@"GET" path:API_GET_APPOINTMENTS parameters:params]];
}
- (RACSignal *)signalRejectAppointment:(NSString *)token
                     withAppointmentID:(NSString *)appointment_id
{
    NSDictionary *params = @{@"token" : token,
                             @"id":appointment_id};
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:API_CANCEL_APPOINTMENT parameters:params]];
}
- (RACSignal *)signalAcceptAppointment:(NSString *)token
                     withAppointmentID:(NSString *)appointment_id
{
    NSDictionary *params = @{@"token" : token,
                             @"id":appointment_id};
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:API_ACCEPT_APPOINTMENT parameters:params]];
}
- (RACSignal *)signalAppointmentAddDoctorNotes:(NSString *)token
                             withAppointmentID:(NSString *)appointment_id
                                withDoctorNote:(NSString *)doctor_notes
{
    NSDictionary *params = @{@"token" : token,
                             @"id":appointment_id,
                             @"doctor_notes" : doctor_notes};
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:API_UPDATE_DOCTOR_NOTE parameters:params]];
}
- (RACSignal *)signalUpdateAppointmentWithToken:(NSString *)token
                             withAppointmentID:(NSString *)appointment_id
                                       withDate:(NSString *)date
                                       withTime:(NSString *)time withAddressId:(NSString *)addressID
{

    NSDictionary *params = @{@"token" : token,
                             @"id":appointment_id,
                             @"date" : NotNillValue(date), @"time" : NotNillValue(time), @"address" : addressID};
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:API_UPDATE_APPOINTMENT parameters:params]];
    
}

- (RACSignal *)signaRegisterPushNotificationWithTokenDevice:(NSString *)tokenDevice WithTokenUser:(NSString *)tokenUser
{
    
    NSDictionary *params = @{@"token" : tokenUser, @"device_token" : NotNillValue(tokenDevice)};
    
    return [self enqueueRequest:[self requestWithMethod:@"POST" path:API_REGISTER_PUSH_NOTIFICATION parameters:params]];
    
}

@end
