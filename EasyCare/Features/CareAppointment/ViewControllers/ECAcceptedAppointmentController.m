//
//  ECAcceptedAppointmentController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/18/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECAcceptedAppointmentController.h"
#import "User.h"
#import "Macros.h"
#import "ECCareAppointmentController.h"
@interface ECAcceptedAppointmentController ()
{
    
}
@end

@implementation ECAcceptedAppointmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoadingInView:self.view];
    self.data = [NSMutableArray array];
    // Do any additional setup after loading the view.
    _currentPage = 1;
    [self loadData];
    
}
- (void)loadData
{
    ECCareAppointmentController *parentController = (ECCareAppointmentController *)self.parentViewController;
    
    [[[ECAppointment signalGetAppointmentsForpatientName:parentController.tfPatientName.text withStatus:ACCEPTED_APPOINTMENT_STATUS date:parentController.tfAppointmentSearchDate.date startDate:parentController.filterStartDate endDate:parentController.filterEndDate appointmentID:parentController.tfAppointmentCode.text pageIndex:_currentPage] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *appointments) {
        [self hideLoadingView];
        [self.data addObjectsFromArray:appointments];
        [self.tableView reloadData];
         self.loadMoreButton.hidden = [appointments count] == 0;
        
    } error:^(NSError *error){
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
//    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ECAppointmentCell *cell = (ECAppointmentCell *)[tableView dequeueReusableCellWithIdentifier:@"AcceptedAppointmentCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setAppointment:[self.data objectAtIndex:indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.appointmentDetail.appointment = [self.data objectAtIndex:indexPath.row];
    [self.appointmentDetail loadGui];
}
- (void)didFinishedRejectAppointment:(ECAppointmentCell *)cell
{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalRejectAppointment:cell.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [Utils showMessage:@"Đã hủy cuộc hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
    } error:^(NSError *error) {
        [Utils showMessage:error.localizedDescription];
    }];
}
#pragma mark - load data 
- (IBAction)loadMore:(id)sender
{
    [self showLoadingInView:self.view];
    _currentPage++;
    [self loadData];
}
- (void)reloadData
{
    self.loadMoreButton.hidden = NO;
    [self showLoadingInView:self.view];
    [self.data removeAllObjects];
    _currentPage = 1;
    [self loadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showAppointmentDetail"]) {
        self.appointmentDetail = segue.destinationViewController;
    }
}


@end
