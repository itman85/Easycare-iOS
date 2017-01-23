/*============================================================================
 PROJECT: EasyCare
 FILE:    ECCalendarDetailViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/20/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECScheduleDetailViewController.h"
#import "ECClinic.h"
#import "DateTimeTextField.h"
#import "ECSchedule.h"
#import "ECScheduleSlot.h"
#import "NSDate+Extensions.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECScheduleDetailViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet DateTimeTextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet DateTimeTextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *periodTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;



@property (nonatomic) NSArray *clinics;
@property (nonatomic) ECClinic *selectedClinic;

@property (nonatomic) UIPickerView *clinicsPickerView;

@property (nonatomic, copy) ECSchedule *schedule;

- (IBAction)didTouchOnCancelButton:(id)sender;
- (IBAction)didTouchOnSaveButton:(id)sender;

@end

@implementation ECScheduleDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.scheduleSlot.schedule) {
        self.schedule = self.scheduleSlot.schedule;
    }else {
        self.schedule = [ECSchedule new];
        //Set default value
        self.schedule.date = self.currentDate;
        self.schedule.startTime = self.scheduleSlot.startDate;
        
        //Default date in picker
        self.endTimeTextField.datePicker.date = [self.scheduleSlot.startDate dateByAddingHours:2];
    }
    
    [self setupUI];
    
    [self setupBinding];
    
    [self loadClinics];
}

#pragma mark - Private methods
- (void)setupUI{
    self.clinicsPickerView = [[UIPickerView alloc] init];
    self.clinicsPickerView.dataSource = self;
    self.clinicsPickerView.delegate = self;
    self.addressTextField.inputView = self.clinicsPickerView;
}

- (void)setupBinding{
    
    @weakify(self);
    [RACObserve(self, selectedClinic) subscribeNext:^(ECClinic *selectedClinic) {
        @strongify(self);
        self.addressTextField.text = selectedClinic.address;
        if (selectedClinic) {
            self.schedule.addressID = selectedClinic.clinicID;
            [self.clinicsPickerView selectRow:[self.clinics indexOfObject:selectedClinic] inComponent:0 animated:NO];
        }
    }];
    
    [RACObserve(self, currentDate) subscribeNext:^(NSDate *date) {
        @strongify(self);
        self.dateLabel.text = [[DateFormatter sharedInstance] stringFromDate:date];
        self.schedule.date = date;
    }];
    
    //Model to UI
    RAC(self.startTimeTextField, date) = RACObserve(self.schedule, startTime);
    
    RAC(self.endTimeTextField, date) = RACObserve(self.schedule, endTime);
    
    RAC(self.periodTextField, text) = [RACObserve(self.schedule, period) map:^id(NSNumber *period) {
        return [period stringValue];
    }];
    
    RAC(self.noteTextView, text) = RACObserve(self.schedule, note);

    //UI to model
    [[self.startTimeTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(DateTimeTextField *textField) {
        @strongify(self);
        self.schedule.startTime = textField.date;
    }];
    
    [[self.endTimeTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(DateTimeTextField *textField) {
        @strongify(self);
        self.schedule.endTime = textField.date;
    }];
    
    [[self.periodTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.schedule.period = @([textField.text integerValue]);
    }];
    
    [[self.noteTextView rac_textSignal] subscribeNext:^(NSString *text) {
        @strongify(self);
        self.schedule.note = text;
    }];
}

- (void)loadClinics{
    [self showLoadingInView:self.view];
    [[[ECClinic signalGetClinics] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *clinics) {
        [self hideLoadingView];
        self.clinics = clinics;
        [self.clinicsPickerView reloadAllComponents];
        [self selectCurrentClinic];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];
}

- (void)selectCurrentClinic{
    if (self.schedule.addressID) {
        for (ECClinic *clinic in self.clinics) {
            if ([clinic.clinicID isEqualToNumber:self.schedule.addressID]) {
                self.selectedClinic = clinic;
            }
        }
    }
    
    if (self.selectedClinic == nil && [self.clinics count] > 0) {
        self.selectedClinic = self.clinics[0];
    }
}

#pragma mark - UIPickerViewDelegate, DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.clinics count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    ECClinic *clinic = self.clinics[row];
    return clinic.address;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedClinic = self.clinics[row];
}

#pragma mark - Event
- (IBAction)didTouchOnCancelButton:(id)sender {
    if (self.schedule.scheduleID) {
        [self showLoadingInView:self.view];
        [[[self.schedule signalDeleteSchedule] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [self hideLoadingView];
            NotifPost(ScheduleAddedOrUpdatedNotification);
            [Utils showMessage:@"Xóa lịch khám thành công"];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [self hideLoadingView];
            [Utils showMessage:[NSString stringWithFormat:@"Xóa lịch khám thất bại: %@", error.localizedDescription]];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)didTouchOnSaveButton:(id)sender {
    [self showLoadingInView:self.view];
    [[[self.schedule signalCreateOrUpdateSchedule] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self hideLoadingView];
        NotifPost(ScheduleAddedOrUpdatedNotification);
        if (self.schedule.scheduleID) {
            [Utils showMessage:@"Cập nhật lịch khám thành công"];
        }else{
            [Utils showMessage:@"Tạo lịch khám thành công"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [self hideLoadingView];
        if (self.schedule.scheduleID) {
            [Utils showMessage:[NSString stringWithFormat:@"Cập nhật lịch khám thất bại: %@", error.localizedDescription]];
        }else{
            [Utils showMessage:[NSString stringWithFormat:@"Tạo lịch khám thất bại: %@", error.localizedDescription]];
        }
        
    }];
}

@end
