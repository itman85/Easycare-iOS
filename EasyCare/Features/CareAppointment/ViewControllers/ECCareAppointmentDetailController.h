//
//  ECCareAppointmentDetailController.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/22/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BaseViewController.h"
#import "ECAppointment.h"
#import "BorderTextField.h"
#import "CustomLabel.h"
@interface ECCareAppointmentDetailController : BaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) ECAppointment *appointment;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfFooter;
@property (weak, nonatomic) IBOutlet BorderTextField *tfDoctorNotes;
@property (weak, nonatomic) IBOutlet CustomLabel *lblAppointmentCode;
@property (weak, nonatomic) IBOutlet CustomLabel *lblAppointmentAddress;
@property (weak, nonatomic) IBOutlet CustomLabel *lblAppointmentName;
@property (weak, nonatomic) IBOutlet CustomLabel *lblVisitReason;
@property (weak, nonatomic) IBOutlet CustomLabel *lblPatientName;
@property (weak, nonatomic) IBOutlet CustomLabel *lblPatientGener;
@property (weak, nonatomic) IBOutlet CustomLabel *lblPatientEmail;
@property (weak, nonatomic) IBOutlet CustomLabel *lblAppointmentStatus;
@property (weak, nonatomic) IBOutlet CustomLabel *lblAppointmentMoreInfo;
@property (weak, nonatomic) IBOutlet CustomLabel *lblCreateDate;
@property (weak, nonatomic) IBOutlet CustomLabel *lblTime;
@property (weak, nonatomic) IBOutlet CustomLabel *lblPatientPhone;
- (void)loadGui;
@end
