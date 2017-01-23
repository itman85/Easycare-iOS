/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsViewController.h
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BaseViewController.h"
#import "PatientTableViewCell.h"
/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   ECPatientsViewController
 =============================================================================*/


@interface ECPatientsViewController : BaseViewController<PatientTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (nonatomic) NSMutableArray *patients;
@property (nonatomic) NSInteger currentPageIndex;

- (IBAction)didTouchOnLoadMoreButton:(id)sender;

- (void)reloadData;
- (void)loadMoreData;

@end
