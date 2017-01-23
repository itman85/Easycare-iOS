/*============================================================================
 PROJECT: EasyCare
 FILE:    ECPatientsCareAppointmentViewController.m
 AUTHOR:  Vien Tran
 DATE:    1/9/15
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECPatientsCareAppointmentViewController.h"
#import "ECPatientsCareAppointmentListViewController.h"
#import "ECPatient.h"
#import "UIImageView+AFNetworking.h"
#import "DateTextField.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECPatientsCareAppointmentViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *waitingAcceptButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptedButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *waitingAcceptView;
@property (weak, nonatomic) IBOutlet UIView *acceptedView;
@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property (weak, nonatomic) IBOutlet UITextField *filterPeriodTextField;
@property (weak, nonatomic) IBOutlet UITextField *filterAppointmentIDTextField;
@property (weak, nonatomic) IBOutlet DateTextField *filterDateTextField;

@property (nonatomic) UIPickerView *filterPeriodPickerView;
@property (nonatomic) NSArray *filterPeriodData;
@property (nonatomic) NSInteger selectedFilterPeriod;

- (IBAction)didTouchOnSegmentedButton:(id)sender;
- (IBAction)didTouchOnRefreshButton:(id)sender;
- (IBAction)didTouchOnSearchButton:(id)sender;


@property (nonatomic) ECPatientsCareAppointmentListViewController *waitingAcceptAppointmentViewController;
@property (nonatomic) ECPatientsCareAppointmentListViewController *acceptedAppointmentViewController;
@property (nonatomic) ECPatientsCareAppointmentListViewController *cancelAppointmentViewController;

@end

@implementation ECPatientsCareAppointmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.patient) {
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.patient.avatarThumbUrl]];
        self.fullNameLabel.text = self.patient.fullName;
        self.birthdayLabel.text = self.patient.birthday;
        self.phoneNumberLabel.text = self.patient.phoneNumber;
        self.emaiLabel.text = self.patient.email;
        self.addressLabel.text = self.patient.address;
    }
    NotifReg(self, @selector(reloadAllAppointmentLists:), ReloadAllAppointmentListNotification);
    
    self.filterPeriodData = @[@"Tất cả", @"Hôm nay", @"Tuần này", @"Tháng này"];
    
    [self setupUI];
    
    [self setupBinding];
    
    self.selectedFilterPeriod = 0;
}

#pragma mark - Private methods
- (void)setupUI{
    self.filterPeriodPickerView = [[UIPickerView alloc] init];
    self.filterPeriodPickerView.delegate = self;
    self.filterPeriodPickerView.dataSource = self;
    self.filterPeriodTextField.inputView = self.filterPeriodPickerView;
}

- (void)setupBinding{
    //Model to UI
    RAC(self.filterDateTextField, date) = RACObserve(self, filterDate);
    RAC(self.filterAppointmentIDTextField, text) = RACObserve(self, filterAppointmentID);
    
    @weakify(self);
    //UI to model
    [[self.filterDateTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(DateTextField *textField) {
        @strongify(self);
        self.filterDate = textField.date;
        //Resert filter period to all
        self.selectedFilterPeriod = 0;
    }];
    
    [[self.filterAppointmentIDTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.filterAppointmentID = textField.text.length > 0 ? textField.text : nil;
    }];
    
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

#pragma mark - Events
- (IBAction)didTouchOnSegmentedButton:(id)sender {
    if (sender == self.waitingAcceptButton) {
        self.waitingAcceptButton.selected = YES;
        self.acceptedButton.selected = NO;
        self.cancelButton.selected = NO;
        
        self.waitingAcceptView.hidden = NO;
        self.acceptedView.hidden = YES;
        self.cancelView.hidden = YES;
    }else if (sender == self.acceptedButton){
        self.waitingAcceptButton.selected = NO;
        self.acceptedButton.selected = YES;
        self.cancelButton.selected = NO;
        
        self.waitingAcceptView.hidden = YES;
        self.acceptedView.hidden = NO;
        self.cancelView.hidden = YES;
    }else{
        self.waitingAcceptButton.selected = NO;
        self.acceptedButton.selected = NO;
        self.cancelButton.selected = YES;
        
        self.waitingAcceptView.hidden = YES;
        self.acceptedView.hidden = YES;
        self.cancelView.hidden = NO;
    }
}

- (IBAction)didTouchOnRefreshButton:(id)sender {
    self.filterAppointmentID = nil;
    self.selectedFilterPeriod = 0;
    self.filterDate = nil;
    [self reloadAllAppointmentLists:nil];
}

#pragma mark - Notification
- (void)reloadAllAppointmentLists:(NSNotification *)noti{
    [self.view endEditing:YES];
    if (self.waitingAcceptAppointmentViewController) {
        [self.waitingAcceptAppointmentViewController reloadData];
    }
    
    if (self.acceptedAppointmentViewController) {
        [self.acceptedAppointmentViewController reloadData];
    }
    
    if (self.cancelAppointmentViewController) {
        [self.cancelAppointmentViewController reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"waitingAcceptAppointmentContainer"]) {
        self.waitingAcceptAppointmentViewController = segue.destinationViewController;
    }else if ([segue.identifier isEqualToString:@"acceptedAppointmentContainer"]) {
        self.acceptedAppointmentViewController = segue.destinationViewController;
    }else if ([segue.identifier isEqualToString:@"cancelAppointmentContainer"]) {
        self.cancelAppointmentViewController = segue.destinationViewController;
    }
}

- (IBAction)didTouchOnSearchButton:(id)sender {
    [self reloadAllAppointmentLists:nil];
}

@end