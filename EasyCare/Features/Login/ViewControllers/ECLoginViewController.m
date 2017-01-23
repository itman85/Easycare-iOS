/*============================================================================
 PROJECT: EasyCare
 FILE:    ECLoginViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECLoginViewController.h"
#import "Validator.h"
#import "User.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)didTouchOnLoginButton:(id)sender;

@end

@implementation ECLoginViewController

#pragma mark - ViewLife Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Private Methods
- (BOOL)validateInput{
    NSString *message = [Validator validateEmail:self.emailTextField.text];
    if (!message) {
        message = [Validator validatePassword:self.passwordTextField.text];
    }
    
    if (message) {
        [Utils showMessage:message];
        return NO;
    }
    
    return YES;
}

#pragma mark - Event
- (IBAction)didTouchOnLoginButton:(id)sender {
    if ([self validateInput]) {
        [self showLoadingInView:self.view];
       /* [[[User signalLoginWithEmail:self.emailTextField.text password:self.passwordTextField.text] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [self hideLoadingView];
            [appDelegate openHomeView];
            // register push notification
            AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
            [appDel registerPushNotificationWithServer];
            
        } error:^(NSError *error) {
            [self hideLoadingView];
            [Utils showMessage:error.localizedDescription];
        }];*/
        [self hideLoadingView];
        [appDelegate openHomeView];
        // register push notification
        AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
        [appDel registerPushNotificationWithServer];
    }
}


@end
