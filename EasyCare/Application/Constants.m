/*============================================================================
 PROJECT: EasyCare
 FILE:    Constants.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "Constants.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation Constants

NSString *const API_BASE_URL = @"http://easycare.vn/api/v1/";
NSString *const API_GET_STATISTIC = @"doctors/statistics";
NSString *const API_GET_COMMENTS  = @"doctors/comments";
NSString *const API_GET_APPOINTMENTS  = @"doctors/appointments";
NSString *const API_CANCEL_APPOINTMENT = @"doctors/appointments/reject";
NSString *const API_ACCEPT_APPOINTMENT = @"doctors/appointments/accept";
NSString *const API_UPDATE_APPOINTMENT = @"doctors/appointments/update";
NSString *const API_UPDATE_DOCTOR_NOTE = @"doctors/appointments/update_doctor_note";
NSString *const API_REGISTER_PUSH_NOTIFICATION = @"doctors/message/apns/register";

NSString *const ERROR_MESSAGE_TOKEN_EXPIRE = @"Hết hạn đăng nhập, vui lòng đăng nhập lại";
NSString *const ERROR_MESSAGE_SERVER_PROBLEM = @"Lỗi kết nối đến máy chủ!";

NSString *const ScheduleAddedOrUpdatedNotification = @"addedOrUpdatedSchedule";
NSString *const PatientBannedOrUnbannedNotification = @"bannedOrUnbannedPatient";
NSString *const ReloadAllAppointmentListNotification = @"ReloadAllAppointmentListNotification";



@end
