/*============================================================================
 PROJECT: EasyCare
 FILE:    Constants.h
 AUTHOR:  Vien Tran
 DATE:    12/12/14
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
 Interface:   Constants
 =============================================================================*/


@interface Constants : NSObject

extern NSString *const API_BASE_URL;
extern NSString *const API_GET_STATISTIC;
extern NSString *const API_GET_COMMENTS;
extern NSString *const API_GET_APPOINTMENTS;
extern NSString *const API_CANCEL_APPOINTMENT;
extern NSString *const API_ACCEPT_APPOINTMENT;
extern NSString *const API_UPDATE_APPOINTMENT;
extern NSString *const API_UPDATE_DOCTOR_NOTE;
extern NSString *const API_REGISTER_PUSH_NOTIFICATION;

extern NSString *const ERROR_MESSAGE_TOKEN_EXPIRE;
extern NSString *const ERROR_MESSAGE_SERVER_PROBLEM;


extern NSString *const ScheduleAddedOrUpdatedNotification;
extern NSString *const PatientBannedOrUnbannedNotification;
extern NSString *const ReloadAllAppointmentListNotification;

@end
