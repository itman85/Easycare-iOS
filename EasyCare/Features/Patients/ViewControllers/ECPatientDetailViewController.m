/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientDetailViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/18/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatientDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ECPatient.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECPatientDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cancelCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeScheduleCountLabel;

@end

@implementation ECPatientDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self displayData];
}

- (void)displayData{
    if (self.patient) {
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.patient.avatarThumbUrl]];
        self.fullNameLabel.text = self.patient.fullName;
        self.birthdayLabel.text = self.patient.birthday;
        self.phoneNumberLabel.text = self.patient.phoneNumber;
        self.emaiLabel.text = self.patient.email;
        self.addressLabel.text = self.patient.address;
        
        self.orderCountLabel.text = [self.patient.visitsCount stringValue];//Temp
        self.cancelCountLabel.text = [self.patient.cancelVisitsCount stringValue];
        self.reviewCountLabel.text = [self.patient.commentCount stringValue];
        self.changeScheduleCountLabel.text = [self.patient.changeAppointmentCount stringValue];
    }
}
@end
