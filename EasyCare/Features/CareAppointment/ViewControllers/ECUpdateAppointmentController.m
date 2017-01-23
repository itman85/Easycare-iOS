//
//  ECUpdateAppointmentController.m
//  EasyCare
//
//  Created by Phan Nguyen on 1/12/15.
//  Copyright (c) 2015 Vien Tran. All rights reserved.
//

#import "ECUpdateAppointmentController.h"
#import "DateTextField.h"
#import "DateTimeTextField.h"
#import "ECAppointment.h"
#import "User.h"
#import "DateFormatter.h"
@interface ECUpdateAppointmentController ()
@property (weak,nonatomic)IBOutlet DateTextField *tfDate;
@property (weak,nonatomic)IBOutlet DateTimeTextField *tfTime;

@end

@implementation ECUpdateAppointmentController
@synthesize appointment;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tfDate setFont:FontRobotoWithSize(12)];
    [self.tfTime setFont:FontRobotoWithSize(12)];
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
-(IBAction)updateAction:(id)sender
{
    NSString *dateStr = [[DateFormatter sharedInstance] apiStringFromDate:self.tfDate.date];
    NSString *timeStr = [[DateFormatter sharedInstance] apiTimeStringFromDate:self.tfTime.date];
    [self showLoadingInView:self.view];
    [[[[User loggedUser] signalUpdateAppointment:self.appointment.appointment_id withDate:dateStr withTime:timeStr withAddressID:appointment.addressID] deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        
        [self hideLoadingView];
         [Utils showMessage:@"Đã đổi lịch hẹn thành công."];
        NotifPost(ReloadAllAppointmentListNotification);
        [self.view removeFromSuperview];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
        [self.view removeFromSuperview];
    }];
}
@end
