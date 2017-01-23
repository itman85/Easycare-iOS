/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatientsViewController.h"
#import "ECPatientDetailViewController.h"
#import "IBHelper.h"
#import "ECPatient.h"
#import "ECPatientsCareAppointmentViewController.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECPatientsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ECPatientsViewController

#pragma mark - ViewLife Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup tableView
    UINib *reuseCellNib = [UINib nibWithNibName:@"PatientTableViewCell" bundle:nil];
    [self.tableView registerNib:reuseCellNib forCellReuseIdentifier:@"PatientTableViewCell"];
    
    self.patients = [NSMutableArray array];
    
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark - Public method
- (void)reloadData{
    [self.patients removeAllObjects];
    self.currentPageIndex = 0;
    
    [self loadMoreData];
}

- (void)loadMoreData{
    self.currentPageIndex++;
    [self showLoadingInView:self.view];
    [[[ECPatient signalGetPatientsWithBanned:NO pageIndex:self.currentPageIndex] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray * patients) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"PatientTableViewCell";
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.patient = self.patients[indexPath.row];
    cell.delegate = self;
    cell.banned = NO;
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ECPatientDetailViewController *patientDetailVC = [IBHelper loadViewController:@"ECPatientDetailViewController" inStory:@"Patients"];
    patientDetailVC.patient = self.patients[indexPath.row];
    [self.navigationController pushViewController:patientDetailVC animated:YES];
}

#pragma mark - PatientTableViewCellDelegate
- (void)patientCellDidSelectAppointments:(PatientTableViewCell *)cell{
    ECPatientsCareAppointmentViewController *patientsAppointmentVC = [IBHelper loadViewController:@"ECPatientsCareAppointmentViewController" inStory:@"Patients"];
    patientsAppointmentVC.patient = cell.patient;
    [self.parentViewController.navigationController pushViewController:patientsAppointmentVC animated:YES];
    
}

- (void)patientCellDidSelectBan:(PatientTableViewCell *)cell{
    @weakify(self);
    [self showLoadingInView:self.view];
    [[[cell.patient signalBan] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self hideLoadingView];
        NotifPost(PatientBannedOrUnbannedNotification);
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

- (void)patientCellDidSelectUnban:(PatientTableViewCell *)cell{
    @weakify(self);
    [self showLoadingInView:self.view];
    [[[cell.patient signalUnban] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self hideLoadingView];
        NotifPost(PatientBannedOrUnbannedNotification);
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

#pragma mark - Event
- (IBAction)didTouchOnLoadMoreButton:(id)sender {
    [self loadMoreData];
}

@end
