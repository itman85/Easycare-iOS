//
//  ECCareAppointmentController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/16/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECCareAppointmentController.h"
#import "ECWaitingAcceptAppointmentController.h"
#import "ECAcceptedAppointmentController.h"
#import "ECCancelAppointmentController.h"
#import "User.h"
#import "DateFormatter.h"
#import "DateTextField.h"

@interface ECCareAppointmentController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *embedWaitingAcceptedView;
@property (weak, nonatomic) IBOutlet UIView *embedAcceptedView;
@property (weak, nonatomic) IBOutlet UIView *embedCancelView;
@property (weak, nonatomic) IBOutlet UIButton *btnWaittingAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnAccepted;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UITextField *filterPeriodTextField;

@property (nonatomic) UIPickerView *filterPeriodPickerView;
@property (nonatomic) NSArray *filterPeriodData;
@property (nonatomic) NSInteger selectedFilterPeriod;

@property (nonatomic) ECWaitingAcceptAppointmentController *waitingAppointmentController;
@property (nonatomic) ECAcceptedAppointmentController *acceptAppointmentController;
@property (nonatomic) ECCancelAppointmentController *cancelAppointmentController;

@end

@implementation ECCareAppointmentController
@synthesize tfAppointmentCode;
@synthesize tfPatientName;
@synthesize tfAppointmentSearchDate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *logoLabel = [[UILabel alloc] init];
    logoLabel.text = @"EasyCare";
    [logoLabel setTextColor:[UIColor whiteColor]];
    [logoLabel setShadowColor:[UIColor blackColor]];
    [logoLabel setShadowOffset:CGSizeMake(0, 0.5f)];
    [logoLabel setFont:FontRobotoBoldWithSize(25)];
    [logoLabel sizeToFit];
    self.navigationItem.titleView = logoLabel;
    
    NotifReg(self, @selector(reloadAllAppointmentList), ReloadAllAppointmentListNotification);
    currentTab = WAITTING_APPOINTMENT_STATUS;
    
    self.filterPeriodData = @[@"Tất cả", @"Hôm nay", @"Tuần này", @"Tháng này"];
    
    [self setupUI];
    
    [self setupBinding];
    
    self.selectedFilterPeriod = 0;

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
#pragma mark - Methods 
- (void)resetUnSelectedButtons
{
    self.btnAccepted.selected = FALSE;
    self.btnCancel.selected = FALSE;
    self.btnWaittingAccept.selected = FALSE;
}
- (void)hidenAllTableView
{
    self.embedAcceptedView.hidden = TRUE;
    self.embedCancelView.hidden = TRUE;
    self.embedWaitingAcceptedView.hidden = TRUE;
}
- (void)loadAppointmentsWithSelectedButton:(UIButton *)btnSelected
{
    [self hidenAllTableView];
    if (btnSelected == self.btnWaittingAccept) {
        self.embedWaitingAcceptedView.hidden = FALSE;
    }
    else if (btnSelected == self.btnCancel)
    {
        self.embedCancelView.hidden = FALSE;
    }
    else if (btnSelected == self.btnAccepted)
    {
        self.embedAcceptedView.hidden = FALSE;
    }
}
#pragma mark - Reload all data of appointments
- (void)reloadAllAppointmentList
{
    if (self.waitingAppointmentController) {
        [self.waitingAppointmentController reloadData];
    }
    if (self.cancelAppointmentController) {
        [self.cancelAppointmentController reloadData];
    }
    if (self.acceptAppointmentController) {
        [self.acceptAppointmentController reloadData];
    }
}

#pragma mark - Navigation 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"waitingAppointmentContainer"]) {
        self.waitingAppointmentController = segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"acceptedAppointmentContainer"]) {
        self.acceptAppointmentController = segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"cancelAppointmentContainer"]) {
        self.cancelAppointmentController = segue.destinationViewController;
    }
}

#pragma mark - Actions
- (IBAction)clickChoDuyetTab:(id)sender {
    [self resetUnSelectedButtons];
    UIButton *btn = (UIButton *)sender;
    btn.selected = TRUE;
    [self loadAppointmentsWithSelectedButton:btn];
    currentTab = WAITTING_APPOINTMENT_STATUS;

}
- (IBAction)clickDaDuyetTab:(id)sender {
    
    [self resetUnSelectedButtons];
    UIButton *btn = (UIButton *)sender;
    btn.selected = TRUE;
    [self loadAppointmentsWithSelectedButton:btn];
    currentTab = ACCEPTED_APPOINTMENT_STATUS;
}
- (IBAction)clickHuyTab:(id)sender {
    
    [self resetUnSelectedButtons];
    UIButton *btn = (UIButton *)sender;
    btn.selected = TRUE;
    [self loadAppointmentsWithSelectedButton:btn];
    currentTab = CANCEL_APPOINMENT_STATUS;
}
- (IBAction)clickSearch:(id)sender
{
     [self reloadAllAppointmentList];
   
}
- (IBAction)refreshData:(id)sender {
    self.tfAppointmentCode.text = @"";
    self.tfAppointmentSearchDate.text = @"";
    self.tfPatientName.text = @"";
    self.selectedFilterPeriod = 0;
    self.filterStartDate = nil;
    self.filterEndDate = nil;
    [self reloadAllAppointmentList];
}
#pragma mark - Private methods
- (void)setupUI{
    self.filterPeriodPickerView = [[UIPickerView alloc] init];
    self.filterPeriodPickerView.delegate = self;
    self.filterPeriodPickerView.dataSource = self;
    self.filterPeriodTextField.inputView = self.filterPeriodPickerView;
}

- (void)setupBinding{

    
    @weakify(self);

    
    [[self.filterPeriodTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.selectedFilterPeriod = [self.filterPeriodPickerView selectedRowInComponent:0];
        //Resert filter date
        self.filterDate = nil;
    }];
    
    [RACObserve(self, selectedFilterPeriod) subscribeNext:^(id x) {
        @strongify(self);
        self.filterPeriodTextField.text = self.filterPeriodData[self.selectedFilterPeriod];
        [self.filterPeriodPickerView selectRow:self.selectedFilterPeriod inComponent:0 animated:NO];
        [self analyseStartDateAndEndDate];
    }];
}

- (void)analyseStartDateAndEndDate{
    switch (self.selectedFilterPeriod) {
        case 0:{ //Tất cả
            self.filterStartDate = nil;
            self.filterEndDate = nil;
        }
            break;
        case 1:{ //Hôm nay
            self.filterStartDate = [NSDate date];
            self.filterEndDate = [NSDate date];;
        }
            break;
        case 2:{ //Tuần này
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDate *now = [NSDate date];
            NSDate *startOfTheWeek;
            NSDate *endOfWeek;
            NSTimeInterval interval;
            [cal rangeOfUnit:NSWeekCalendarUnit
                   startDate:&startOfTheWeek
                    interval:&interval
                     forDate:now];
            endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
            
            self.filterStartDate = startOfTheWeek;
            self.filterEndDate = endOfWeek;
        }
            break;
        case 3:{ //Tháng này
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDate *now = [NSDate date];
            NSDate *startOfTheMonth;
            NSDate *endOfMonth;
            NSTimeInterval interval;
            [cal rangeOfUnit:NSMonthCalendarUnit
                   startDate:&startOfTheMonth
                    interval:&interval
                     forDate:now];
            endOfMonth = [startOfTheMonth dateByAddingTimeInterval:interval-1];
            
            self.filterStartDate = startOfTheMonth;
            self.filterEndDate = endOfMonth;
        }
            break;
            
        default:{
            self.filterStartDate = nil;
            self.filterEndDate = nil;
        }
            break;
    }
}

#pragma mark - UIPickerViewDelegate, Datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.filterPeriodData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.filterPeriodData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.filterPeriodTextField.text = self.filterPeriodData[row];
}

@end
