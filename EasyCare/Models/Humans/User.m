#import "User.h"
#import "EasyCareApiClient.h"
#import "ECPatient.h"
#import "ECStatistic.h"
#import "ECComment.h"
#import "ECAppointment.h"
#import "ECPageInfo.h"
#import "EasyCareApiClient.h"
@interface User ()

// Private interface goes here.

@end

@implementation User
+ (User *)loggedUser{
    return [User MR_findFirst];
}

+ (RACSignal *)signalLoginWithEmail:(NSString *)email password:(NSString *)password{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[EasyCareApiClient shared] signalLoginWithEmail:email password:password] subscribeNext:^(NSDictionary *responseDict) {
            User *user = [self createUserFromDictionary:responseDict];
            [subscriber sendNext:user];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return [signal replayLazily];
}

+ (User *)createUserFromDictionary:(NSDictionary*)dictionary{
    User *user = [User MR_createEntity];
    
    user.token = dictionary[@"token"];
    NSDictionary *userInfoDict = dictionary[@"user"];
    user.userID = userInfoDict[@"id"];
    user.email = userInfoDict[@"email"];
    user.fullName = userInfoDict[@"full_name"];
    user.avatarUrl = userInfoDict[@"avatar"];
    user.avatarThumbUrl = userInfoDict[@"avatar_thumb"];
    
    //Save user
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
    
    return user;
}


- (RACSignal *)signalLogout{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalLogoutWithToken:self.token] subscribeNext:^(id x) {
            [User MR_truncateAll];
            //Save user
            [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:nil];
            
            [subscriber sendNext:nil];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
    return signal;
}

#pragma mark - Statistic
- (RACSignal *)signalGetStatistic
{
    // call API Get Statictis
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetStatictis:self.token]subscribeNext:^(id responseDict) {
            NSDictionary *statisticsDict = responseDict[@"statistics"];
            ECStatistic *statistic = [ECStatistic statisticWithDictionary:statisticsDict];
            [subscriber sendNext:statistic];

        }error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}

#pragma mark - Comments 
- (RACSignal *)signalGetCommentsWithCurrentPage:(int)page
{
    // call API Get Statictis
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetCommentsWithToken:self.token withCurrentPage:page]subscribeNext:^(id responseDict) {
            NSLog(@"Response dict of comments : %@", responseDict);
            NSArray *commentsDict = [responseDict objectForKey:@"comments"];
            NSMutableArray *comments = [NSMutableArray arrayWithCapacity:commentsDict.count];
            for (NSDictionary *dict in commentsDict) {
                ECComment *comment = [ECComment commentWithDictionary:dict];
                [comments addObject:comment];
            }

            [subscriber sendNext:comments];
            
        }error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}

#pragma mark - Appointments 
- (RACSignal *)signalSearchAppointmentswithStatus:(int)status
                             withAppointmentCode:(NSString *)code
                                   withStartDate:(NSString *)startdate
                                     withEndDate:(NSString *)endDate
                                        withPage:(int)page
                              withNumberOfRecord:(int)numberOfRecords
                                 withPatientName:(NSString *)patientName
{
    // call API Get Appointments
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalSearchAppointmentsWithToken:self.token
                                                        withStatus:status withAppointmentCode:code withStartDate:startdate withEndDate:endDate withPage:page withNumberOfRecord:numberOfRecords withPatientName:patientName] subscribeNext:^(id responseDict) {
            NSArray *appoinmentsArray = [responseDict objectForKey:@"appointments"];
            NSMutableArray *appointments = [NSMutableArray array];
            NSLog(@"Response dict of appointment for status :%d : %@", status,appoinmentsArray);
            for (NSDictionary *dict in appoinmentsArray) {
                
                ECAppointment *appointment = [ECAppointment appointmentWithDict:dict];
                [appointments addObject:appointment];
            }
            // parse page info
            
            NSDictionary *pageDict = [responseDict objectForKey:@"paging"];
            ECPageInfo *pageinfo = [ECPageInfo pageWithDict:pageDict];
            
            
            NSDictionary *result = @{@"appointments" : appointments,
                                     @"pageInfo": pageinfo};
            [subscriber sendNext:result];

            
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}

- (RACSignal *)signalGetAppointmentsWithStatus:(int)status
                                      withPage:(int)page
                           withNumberOfRecords:(int)numberOfRecords
{
    // call API Get Appointments
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalGetAppointmentsWithToken:self.token withStatus:status withPage:page withNumberOfRecord:numberOfRecords]subscribeNext:^(id responseDict) {
            NSArray *appoinmentsArray = [responseDict objectForKey:@"appointments"];
            NSMutableArray *appointments = [NSMutableArray array];
             NSLog(@"Response dict of appointment for status :%d : %@", status,appoinmentsArray);
            for (NSDictionary *dict in appoinmentsArray) {
               
                ECAppointment *appointment = [ECAppointment appointmentWithDict:dict];
                [appointments addObject:appointment];
            }
            // parse page info
            
            NSDictionary *pageDict = [responseDict objectForKey:@"paging"];
            ECPageInfo *pageinfo = [ECPageInfo pageWithDict:pageDict];
            

            NSDictionary *result = @{@"appointments" : appointments,
                                     @"pageInfo": pageinfo};
            [subscriber sendNext:result];
            
        }error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}
- (RACSignal *)signalRejectAppointment:(NSString *)appointment_id
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalRejectAppointment:self.token withAppointmentID:appointment_id] subscribeNext:^(id x) {
            NSLog(@"reject appointment with response : %@",x );
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}
- (RACSignal *)signalAcceptAppointment:(NSString *)appointment_id
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalAcceptAppointment:self.token withAppointmentID:appointment_id] subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}

- (RACSignal *)signalUpdateAppointment:(NSString *)appointment_id
                              withDate:(NSString *)date
                              withTime:(NSString *)time withAddressID:(NSString *)addressID
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalUpdateAppointmentWithToken:self.token withAppointmentID:appointment_id withDate:date withTime:time withAddressId:addressID] subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}
- (RACSignal *)signalUpdatNoteAppointment:(NSString *)appointment_id
                       withDoctorNotes:(NSString *)doctorNotes
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signalAppointmentAddDoctorNotes:self.token withAppointmentID:appointment_id withDoctorNote:doctorNotes] subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}
- (RACSignal *)signalRegisterNotificationWithTokenDevice:(NSString *)token
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[EasyCareApiClient shared] signaRegisterPushNotificationWithTokenDevice:token WithTokenUser:self.token] subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return [signal replayLazily];
}

@end
