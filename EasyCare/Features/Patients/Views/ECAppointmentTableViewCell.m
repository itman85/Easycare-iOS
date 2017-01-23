/*============================================================================
 PROJECT: EasyCare
 FILE:    ECAppointmentTableViewCell.m
 AUTHOR:  Vien Tran
 DATE:    1/9/15
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECAppointmentTableViewCell.h"
#import "ECAppointment.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
#define ButtonWidth 55
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface ECAppointmentTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *changeScheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

- (IBAction)didTouchOnChangeScheduleButton:(id)sender;
- (IBAction)didTouchOnCancelButton:(id)sender;
- (IBAction)didTouchOnAcceptButton:(id)sender;

@end


@implementation ECAppointmentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setAppointment:(ECAppointment *)appointment{
    if (_appointment != appointment) {
        _appointment = appointment;
    }
    
    self.descriptionLabel.text = self.appointment.visit_reason;
    self.timeLabel.text = [[DateFormatter sharedInstance] stringFromDateTime:self.appointment.time];
    
    switch (self.appointment.status) {
        case WAITTING_APPOINTMENT_STATUS:{
            self.changeScheduleButton.hidden = NO;
            self.cancelButton.hidden = NO;
            self.acceptButton.hidden = NO;
        }
            break;
        case ACCEPTED_APPOINTMENT_STATUS:{
            self.changeScheduleButton.hidden = YES;
            self.cancelButton.hidden = NO;
            self.acceptButton.hidden = YES;
        }
            break;
        case CANCEL_APPOINMENT_STATUS:{
            self.changeScheduleButton.hidden = YES;
            self.cancelButton.hidden = YES;
            self.acceptButton.hidden = YES;
            
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)didTouchOnChangeScheduleButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(appointmentCellDidSelectChangeScheduleButton:)]) {
        [_delegate appointmentCellDidSelectChangeScheduleButton:self];
    }
}

- (IBAction)didTouchOnCancelButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(appointmentCellDidSelectCancelButton:)]) {
        [_delegate appointmentCellDidSelectCancelButton:self];
    }
}

- (IBAction)didTouchOnAcceptButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(appointmentCellDidSelectAcceptButton:)]) {
        [_delegate appointmentCellDidSelectAcceptButton:self];
    }
}
@end
