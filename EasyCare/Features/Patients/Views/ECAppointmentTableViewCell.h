/*============================================================================
 PROJECT: EasyCare
 FILE:    ECAppointmentTableViewCell.h
 AUTHOR:  Vien Tran
 DATE:    1/9/15
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
@class ECAppointmentTableViewCell;
@protocol ECAppointmentTableViewCellDelegate <NSObject>

- (void)appointmentCellDidSelectChangeScheduleButton:(ECAppointmentTableViewCell *)cell;
- (void)appointmentCellDidSelectCancelButton:(ECAppointmentTableViewCell *)cell;
- (void)appointmentCellDidSelectAcceptButton:(ECAppointmentTableViewCell *)cell;

@end

/*============================================================================
 Interface:   ECAppointmentTableViewCell
 =============================================================================*/
@class ECAppointment;
@interface ECAppointmentTableViewCell : UITableViewCell

@property (nonatomic) ECAppointment *appointment;

@property (nonatomic, weak) id<ECAppointmentTableViewCellDelegate> delegate;

@end
