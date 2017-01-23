//
//  ECCareAppointmentDetailController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/22/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECCareAppointmentDetailController.h"
#import "User.h"
#import "Utils.h"
#import "DateFormatter.h"
#import "ECUpdateAppointmentController.h"
@interface ECCareAppointmentDetailController ()
{
    CGRect keyboardRect;

    BOOL isReturned;
    IBOutlet UIButton *btnAccept;
    IBOutlet UIButton *btnReject;
    IBOutlet UIButton *btnUpdate;
    IBOutlet UILabel *lblFooterTitle;
    IBOutlet UIView *line;
    IBOutlet UIView *buttonsView;
}
@end

@implementation ECCareAppointmentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    isReturned = TRUE;
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    if (self.appointment) {
        [self loadGui];
    }
   
}
//- (void)keyboardWillChange:(NSNotification *)notification {
//     keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil]; //this is it!
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadGui
{
    NSLog(@"Appointment : %@", self.appointment);
    self.tfDoctorNotes.text = self.appointment.doctor_notes;
    self.lblAppointmentCode.text = [NSString stringWithFormat:@": %@",self.appointment.code] ;
    self.lblAppointmentAddress.text = [NSString stringWithFormat:@": %@",self.appointment.address] ;
    self.lblVisitReason.text = [NSString stringWithFormat:@": %@",self.appointment.visit_reason] ;
    self.lblPatientEmail.text = [NSString stringWithFormat:@": %@",self.appointment.patient.email] ;
    self.lblPatientName.text = [NSString stringWithFormat:@": %@",self.appointment.patient.fullName] ;
    self.lblAppointmentName.text = [NSString stringWithFormat:@": %@",self.appointment.examine_for] ;
    if ([self.appointment.patient_notes intValue] == 0) {
        self.lblAppointmentMoreInfo.text = @": Không có";
    }
    else
    {
        self.lblAppointmentMoreInfo.text = [NSString stringWithFormat:@": %@",self.appointment.patient_notes] ;
        
    }
    if (self.appointment.patient.gender == TRUE) {
        self.lblPatientGener.text = @": Nam";
    }
    else
    {
        self.lblPatientGener.text = @": Nữ";
    }
    switch (self.appointment.status) {
        case WAITTING_APPOINTMENT_STATUS:
        {
            self.lblAppointmentStatus.text = @": Chờ Khám";
            break;
        }
        case ACCEPTED_APPOINTMENT_STATUS:
        {
            self.lblAppointmentStatus.text = @": Chấp nhận khám";
            break;
        }

        case CANCEL_APPOINMENT_STATUS:
        {
            self.lblAppointmentStatus.text = @": Hủy khám";
            break;
        }

        default:
            break;
    }
    NSString *timeStr = [[DateFormatter sharedInstance] stringFromDateTime:self.appointment.time];
    
    
    NSString *dateStr = [[DateFormatter sharedInstance] stringFromDate:self.appointment.created_at];
    
    self.lblCreateDate.text = [NSString stringWithFormat:@": %@",dateStr] ;
    self.lblTime.text = [NSString stringWithFormat:@": %@",timeStr];
    [self loadGUIWithStatus:(int)self.appointment.status];
    self.lblPatientPhone.text = [NSString stringWithFormat:@": %@",self.appointment.patient.phoneNumber] ;
}
- (void)loadGUIWithStatus:(int)status
{
    if (status == ACCEPTED_APPOINTMENT_STATUS)
    {
        btnReject.hidden = NO;
        btnAccept.hidden = YES;
        btnUpdate.hidden = YES;
                [buttonsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]]];
    }
    else if (status == CANCEL_APPOINMENT_STATUS)
    {
        btnReject.hidden = YES;
        btnAccept.hidden = YES;
        btnUpdate.hidden = YES;
    }
    else
    {
        btnReject.hidden = NO;
        btnAccept.hidden = NO;
        btnUpdate.hidden = NO;
                [buttonsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern.png"]]];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)scrollViewToCenterOfScreen:(UIView *)theView
//{
//    CGFloat viewCenterY = theView.center.y + theView.superview.center.y;
//    CGFloat availableHeight;
//    CGFloat y;
//    
//    if(!isReturned)
//    {
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
//        {
//            availableHeight = 1080;
//        }
//        else
//        {
//            availableHeight = 220;
//        }
//    }
//    else
//    {
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
//        {
//            availableHeight = 1400;
//        }
//        else
//        {
//            availableHeight = 530;
//        }
//        
//    }
//    
//    y = viewCenterY - availableHeight / 2.0;
//    if (y < 0) {
//        y = 0;
//    }
//    [self.contentScrollView setContentOffset:CGPointMake(0, y) animated:YES];
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//   [self scrollViewToCenterOfScreen:textField];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    isReturned = FALSE;
//   [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [textField resignFirstResponder];
    return TRUE;
}
- (IBAction)addDoctorNotes:(id)sender
{
    [self.tfDoctorNotes resignFirstResponder];
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalUpdatNoteAppointment:self.appointment.appointment_id withDoctorNotes:self.tfDoctorNotes.text] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *result) {
        [self hideLoadingView];
        self.appointment.doctor_notes = self.tfDoctorNotes.text;
        [Utils showMessage:@"Đã cập nhật chú thích của bác sĩ thành công."];
        
    }error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:@"Thao tác cập nhật chú thích của bác sĩ thất bại."];
    }];
}

#pragma mark - Actions 
- (IBAction)acceptAction:(id)sender
{
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalAcceptAppointment:self.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [Utils showMessage:@"Đã đồng ý cuộc hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
        [self hideLoadingView];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}
- (IBAction)rejectAction:(id)sender
{
    
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalRejectAppointment:self.appointment.appointment_id] deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        [Utils showMessage:@"Đã hủy cuộc hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
        [self hideLoadingView];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];

}
- (IBAction)updateAction:(id)sender
{
    ECUpdateAppointmentController *updateController = [IBHelper loadViewController:@"ECUpdateAppointmentController" inStory:@"CareAppointment"];
    
    updateController.appointment = self.appointment;
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDel.window.rootViewController.view addSubview:updateController.view];
    
    [appDel.window.rootViewController addChildViewController:updateController];
    [updateController didMoveToParentViewController:appDel.window.rootViewController];
}

@end
