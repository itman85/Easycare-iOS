/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsCareAppointmentListViewController.h
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
 Interface:   ECPatientsCareAppointmentListViewController
 =============================================================================*/

@class ECPatient;
@interface ECPatientsCareAppointmentListViewController : BaseViewController {
    NSNumber *_appointmentStatus;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (nonatomic) NSMutableArray *appointments;
@property (nonatomic) NSInteger currentPageIndex;

@property (nonatomic, readonly) NSNumber *appointmentStatus;

- (IBAction)didTouchOnLoadMoreButton:(id)sender;

- (void)reloadData;
- (void)loadMoreData;

@end
