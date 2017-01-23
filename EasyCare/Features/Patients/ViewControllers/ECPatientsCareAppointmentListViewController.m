/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsCareAppointmentListViewController.m
 AUTHOR:  Vien Tran
 DATE:    1/9/15
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatientsCareAppointmentListViewController.h"
#import "ECAppointmentTableViewCell.h"
#import "IBHelper.h"
#import "ECAppointment.h"
#import "ECCareAppointmentDetailController.h"
#import "ECPatientsCareAppointmentViewController.h"
#import "User.h"
#import "ECUpdateAppointmentController.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECPatientsCareAppointmentListViewController ()<UITableViewDataSource, UITableViewDelegate, ECAppointmentTableViewCellDelegate>

@end

@implementation ECPatientsCareAppointmentListViewController

#pragma mark - ViewLife Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup tableView
    UINib *reuseCellNib = [UINib nibWithNibName:@"ECAppointmentTableViewCell" bundle:nil];
    [self.tableView registerNib:reuseCellNib forCellReuseIdentifier:@"ECAppointmentTableViewCell"];
    
    self.appointments = [NSMutableArray array];
    
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark - Public method
- (void)reloadData{
    [self.appointments removeAllObjects];
    self.currentPageIndex = 0;
    
    [self loadMoreData];
}

- (void)loadMoreData{
    self.currentPageIndex++;
    [self showLoadingInView:self.view];
    ECPatientsCareAppointmentViewController *parentVC = (ECPatientsCareAppointmentViewController*)self.parentViewController;
    
    [[[ECAppointment signalGetAppointmentsForPatient:parentVC.patient withStatus:[self.appointmentStatus integerValue] date:parentVC.filterDate startDate:parentVC.filterStartDate endDate:parentVC.filterEndDate appointmentID:parentVC.filterAppointmentID pageIndex:self.currentPageIndex] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *appointments) {
        [self hideLoadingView];
        [self.appointments addObjectsFromArray:appointments];
        [self.tableView reloadData];
        self.loadMoreButton.hidden = appointments.count == 0;
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.appointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ECAppointmentTableViewCell";
    ECAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.appointment = self.appointments[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ECCareAppointmentDetailController *appointmentDetailVC = [IBHelper loadViewController:@"ECCareAppointmentDetailController" inStory:@"CareAppointment"];
    appointmentDetailVC.appointment = self.appointments[indexPath.row];
    [self.navigationController pushViewController:appointmentDetailVC animated:YES];
}

#pragma mark - ECAppointmentTableViewCellDelegate
- (void)appointmentCellDidSelectChangeScheduleButton:(ECAppointmentTableViewCell *)cell{
    ECUpdateAppointmentController *updateController = [IBHelper loadViewController:@"ECUpdateAppointmentController" inStory:@"CareAppointment"];
    updateController.appointment = cell.appointment;
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDel.window.rootViewController.view addSubview:updateController.view];
    [appDel.window.rootViewController addChildViewController:updateController];
    [updateController didMoveToParentViewController:appDel.window.rootViewController];
}

- (void)appointmentCellDidSelectCancelButton:(ECAppointmentTableViewCell *)cell{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalRejectAppointment:cell.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [self hideLoadingView];
        NotifPost(ReloadAllAppointmentListNotification);
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

- (void)appointmentCellDidSelectAcceptButton:(ECAppointmentTableViewCell *)cell{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalAcceptAppointment:cell.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self hideLoadingView];
        NotifPost(ReloadAllAppointmentListNotification);
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