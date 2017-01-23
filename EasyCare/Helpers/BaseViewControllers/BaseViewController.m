/*============================================================================
 PROJECT: EasyCare
 FILE:    BaseViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BaseViewController.h"
#import "UIViewController+AMSlideMenu.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface BaseViewController ()
{
    UIView *loadingView;
}
@end

@implementation BaseViewController

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
    
    UILabel *logoLabel = [[UILabel alloc] init];
    logoLabel.text = @"EasyCare";
    [logoLabel setTextColor:[UIColor whiteColor]];
    [logoLabel setShadowColor:[UIColor blackColor]];
    [logoLabel setShadowOffset:CGSizeMake(0, 0.5f)];
    [logoLabel setFont:FontRobotoBoldWithSize(25)];
    [logoLabel sizeToFit];
    self.navigationItem.titleView = logoLabel;
    
    //Add menu button
    [self addLeftMenuButton];
    
    //Backbutton
    if (self.navigationController && self != self.navigationController.viewControllers[0]) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(didTouchOnBackButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}
- (void)showLoadingInView:(UIView *)view
{
    if (!loadingView) {
        loadingView =[[UIView alloc] initWithFrame:view.frame];
        
        UIView *blackView = [[UIView alloc] initWithFrame:view.frame];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.3;
        [loadingView addSubview:blackView];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        indicator.center = loadingView.center;
        [loadingView addSubview:indicator];
        
        
        [view addSubview:loadingView];
        loadingView.center = view.center;
    }
}

- (void)hideLoadingView
{
    if (loadingView) {
        [loadingView removeFromSuperview];
        loadingView = nil;
    }
}

#pragma mark - Private methods
- (void)didTouchOnBackButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
