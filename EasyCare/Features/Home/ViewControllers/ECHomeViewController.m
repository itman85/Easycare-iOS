//
//  ECHomeViewController.m
//  EasyCare
//
//  Created by Chau luu on 12/14/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECHomeViewController.h"
#import "IBHelper.h"
#import "ECCareAppointmentController.h"
#import "ECExaminationCalendarViewController.h"
#import "ECPatientsListViewController.h"
@interface ECHomeViewController ()

@end

@implementation ECHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)clickManageCarePoint:(id)sender {
    ECCareAppointmentController *careAppointMent = [IBHelper loadViewController:@"CareAppointmentViewController" inStory:@"CareAppointment"];
    [self.navigationController  pushViewController:careAppointMent animated:YES];
}
- (IBAction)clickExaminationCalendar:(id)sender { // tao lich
    ECExaminationCalendarViewController *calendar = [IBHelper loadViewController:@"ExaminationCalendarViewController" inStory:@"ExaminationCalendar"];
    [self.navigationController  pushViewController:calendar animated:YES];
}
- (IBAction)clickPatients:(id)sender {
    ECPatientsListViewController *patient = [IBHelper loadViewController:@"PatientsListViewController" inStory:@"Patients"];
    [self.navigationController  pushViewController:patient animated:YES];
}
@end
