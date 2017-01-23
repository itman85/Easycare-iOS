//
//  ECCareAppointmentController.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/16/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BaseViewController.h"
#import "DateFormatter.h"
#import "DateTextField.h"
@interface ECCareAppointmentController : BaseViewController
{
    int currentTab;
}
@property (weak, nonatomic) IBOutlet UITextField *tfAppointmentCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPatientName;
@property (weak, nonatomic) IBOutlet DateTextField *tfAppointmentSearchDate;

@property (nonatomic) NSDate *filterStartDate;
@property (nonatomic) NSDate *filterEndDate;
@property (nonatomic) NSDate *filterDate;

@end
