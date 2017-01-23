//
//  ECWaitingAcceptAppointmentControllerViewController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/18/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECWaitingAcceptAppointmentController.h"
#import "User.h"
#import "Macros.h"
#import "IBHelper.h"
#import "ECUpdateAppointmentController.h"
#import "ECCareAppointmentController.h"
@interface ECWaitingAcceptAppointmentController ()
@end

@implementation ECWaitingAcceptAppointmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [NSMutableArray array];
     [self showLoadingInView:self.view];
    self.currentPage = 1;
    [self loadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showAppointmentDetail"]) {
        self.appointmentDetail = segue.destinationViewController;
    }
}


#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECAppointmentCell *cell = (ECAppointmentCell *)[tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setAppointment:[self.data objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.appointmentDetail.appointment = [self.data objectAtIndex:indexPath.row];
    [self.appointmentDetail loadGui];
}
#pragma mark - Load data
- (void)loadData
{
    
    ECCareAppointmentController *parentController = (ECCareAppointmentController *)self.parentViewController;
    
    [[[ECAppointment signalGetAppointmentsForpatientName:parentController.tfPatientName.text withStatus:WAITTING_APPOINTMENT_STATUS date:parentController.tfAppointmentSearchDate.date startDate:parentController.filterStartDate endDate:parentController.filterEndDate appointmentID:parentController.tfAppointmentCode.text pageIndex:_currentPage] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *appointments) {
        [self hideLoadingView];
        [self.data addObjectsFromArray:appointments];
        [self.tableView reloadData];
        self.loadMoreButton.hidden = [appointments count] == 0;
    
    } error:^(NSError *error){
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

- (void)reloadData
{
    self.loadMoreButton.hidden = NO;
    [self showLoadingInView:self.view];
    [self.data removeAllObjects];
    _currentPage = 1;
    [self loadData];

}
- (IBAction)loadMore:(id)sender
{
    [self showLoadingInView:self.view];
    _currentPage++;
    [self loadData];
}
#pragma mark - ECAppointmentCellDelegate
- (void)didFinishedAcceptAppointment:(ECAppointmentCell *)cell
{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalAcceptAppointment:cell.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [Utils showMessage:@"Đã đồng ý cuộc hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
        [self hideLoadingView];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
    
    
}
- (void)didFinishedRejectAppointment:(ECAppointmentCell *)cell
{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalRejectAppointment:cell.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [Utils showMessage:@"Đã hủy cuộc hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
        [self hideLoadingView];
    } error:^(NSError *error) {
        [Utils showMessage:error.localizedDescription];
        [self hideLoadingView];
    }];
    
    
}
-(void)didFinishedUpdateAppointment:(ECAppointmentCell *)cell
{
    ECUpdateAppointmentController *updateController = [IBHelper loadViewController:@"ECUpdateAppointmentController" inStory:@"CareAppointment"];

    updateController.appointment = cell.appointment;
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDel.window.rootViewController.view addSubview:updateController.view];
    
    [appDel.window.rootViewController addChildViewController:updateController];
    [updateController didMoveToParentViewController:appDel.window.rootViewController];
}

@end
