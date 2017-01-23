/*============================================================================
 PROJECT: EasyCare
 FILE:    ECBlacklistViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECBlacklistViewController.h"
#import "IBHelper.h"
#import "ECPatient.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface ECBlacklistViewController ()

@end

@implementation ECBlacklistViewController

#pragma mark - ViewLife Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Override
- (void)loadMoreData{
    self.currentPageIndex++;
    [self showLoadingInView:self.view];
    [[[ECPatient signalGetPatientsWithBanned:YES pageIndex:self.currentPageIndex] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray * patients) {
        [self hideLoadingView];
        [self.patients addObjectsFromArray:patients];
        [self.tableView reloadData];
        self.loadMoreButton.hidden = patients.count == 0;
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"PatientTableViewCell";
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.patient = self.patients[indexPath.row];
    cell.delegate = self;
    cell.banned = YES;
    return cell;
}


@end
