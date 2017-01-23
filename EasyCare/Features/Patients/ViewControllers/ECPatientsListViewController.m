/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsListViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatientsListViewController.h"
#import "ECPatientsViewController.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECPatientsListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *patientsListButton;
@property (weak, nonatomic) IBOutlet UIButton *blacklistButton;
@property (weak, nonatomic) IBOutlet UIView *patientsView;
@property (weak, nonatomic) IBOutlet UIView *blacklistView;

- (IBAction)didTouchOnSegmentedButton:(id)sender;
- (IBAction)didTouchOnRefreshButton:(id)sender;

@property (nonatomic) ECPatientsViewController *patientsViewController;
@property (nonatomic) ECPatientsViewController *blacklistViewController;

@end

@implementation ECPatientsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NotifReg(self, @selector(reloadAllPatientsList:), PatientBannedOrUnbannedNotification);
}

- (IBAction)didTouchOnSegmentedButton:(id)sender {
    if (sender == self.patientsListButton) {
        self.patientsListButton.selected = YES;
        self.blacklistButton.selected = NO;
        
        self.patientsView.hidden = NO;
        self.blacklistView.hidden = YES;
    }else{
        self.patientsListButton.selected = NO;
        self.blacklistButton.selected = YES;
        
        self.patientsView.hidden = YES;
        self.blacklistView.hidden = NO;
    }
}

- (IBAction)didTouchOnRefreshButton:(id)sender {
    [self reloadAllPatientsList:nil];
}

#pragma mark - Notification
- (void)reloadAllPatientsList:(NSNotification *)noti{
    if (self.patientsViewController) {
        [self.patientsViewController reloadData];
    }
    
    if (self.blacklistViewController) {
        [self.blacklistViewController reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"patientsContainer"]) {
        self.patientsViewController = segue.destinationViewController;
    }else if ([segue.identifier isEqualToString:@"blacklistContainer"]) {
        self.blacklistViewController = segue.destinationViewController;
    }
}

@end
