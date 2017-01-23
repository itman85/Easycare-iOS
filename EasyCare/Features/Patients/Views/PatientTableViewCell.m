/*============================================================================
 PROJECT: EasyCare
 FILE:    PatientTableViewCell.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "PatientTableViewCell.h"
#import "ECPatient.h"
#import "UIImageView+AFNetworking.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface PatientTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (weak, nonatomic) IBOutlet UIButton *appointmentsButton;

- (IBAction)didTouchOnBlockButton:(id)sender;
- (IBAction)didTouchOnAppointmentsButton:(id)sender;

@end

@implementation PatientTableViewCell

- (void)setBanned:(BOOL)banned{
    _banned = banned;
    
    if (self.banned) {
        [self.blockButton setTitle:@"Bỏ chặn" forState:UIControlStateNormal];
    }else{
        [self.blockButton setTitle:@"Chặn" forState:UIControlStateNormal];
    }
}

- (void)setPatient:(ECPatient *)patient{
    if (_patient != patient) {
        _patient = patient;
        
        self.fullNameLabel.text = patient.fullName;
        self.avatarImageView.image = nil;
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:patient.avatarThumbUrl]];
        self.phoneNumberLabel.text = patient.phoneNumber;
        self.emailLabel.text = patient.email;
    }
}

- (IBAction)didTouchOnBlockButton:(id)sender {
    if (self.banned) {
        if (_delegate && [_delegate respondsToSelector:@selector(patientCellDidSelectUnban:)]) {
            [_delegate patientCellDidSelectUnban:self];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(patientCellDidSelectBan:)]) {
            [_delegate patientCellDidSelectBan:self];
        }
    }
}

- (IBAction)didTouchOnAppointmentsButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(patientCellDidSelectBan:)]) {
        [_delegate patientCellDidSelectAppointments:self];
    }
}
@end
