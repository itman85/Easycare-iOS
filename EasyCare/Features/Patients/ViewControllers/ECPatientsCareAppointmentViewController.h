/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsCareAppointmentViewController.h
 AUTHOR:  Vien Tran
 DATE:    1/9/15
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BaseViewController.h"

/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   ECPatientsCareAppointmentViewController
 =============================================================================*/

@class ECPatient;
@interface ECPatientsCareAppointmentViewController : BaseViewController

@property (nonatomic) ECPatient *patient;

@property (nonatomic) NSDate *filterStartDate;
@property (nonatomic) NSDate *filterEndDate;
@property (nonatomic) NSDate *filterDate;
@property (nonatomic) NSString *filterAppointmentID;

@end
