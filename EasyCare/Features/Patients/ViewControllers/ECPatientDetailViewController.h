/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientDetailViewController.h
 AUTHOR:  Vien Tran
 DATE:    12/18/14
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
 Interface:   ECPatientDetailViewController
 =============================================================================*/

@class ECPatient;
@interface ECPatientDetailViewController : BaseViewController

@property (nonatomic) ECPatient *patient;
@end
