/*============================================================================
 PROJECT: EasyCare
 FILE:    PatientTableViewCell.h
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import <UIKit/UIKit.h>


/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/
@class PatientTableViewCell;
@protocol PatientTableViewCellDelegate <NSObject>

- (void)patientCellDidSelectBan:(PatientTableViewCell*)cell;
- (void)patientCellDidSelectUnban:(PatientTableViewCell *)cell;
- (void)patientCellDidSelectAppointments:(PatientTableViewCell *)cell;

@end
/*============================================================================
 Interface:   PatientTableViewCell
 =============================================================================*/

@class ECPatient;
@interface PatientTableViewCell : UITableViewCell

@property (nonatomic) BOOL banned;
@property (nonatomic, weak) ECPatient *patient;

@property (nonatomic, weak) id<PatientTableViewCellDelegate> delegate;

@end
