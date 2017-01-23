/*============================================================================
 PROJECT: EasyCare
 FILE:    ECExaminationCalendarViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECExaminationCalendarViewController.h"
#import "ECCalendarTableViewCell.h"
#import "ECScheduleDetailViewController.h"
#import "ECSchedule.h"
#import "ECScheduleSlot.h"
#import "NSDate+Extensions.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
#define DEFAUTL_TIME_PERIOD 15
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECExaminationCalendarViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *schedulesTableView;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *currentDateTextField;

- (IBAction)didTouchOnBackDateButton:(id)sender;
- (IBAction)didTouchOnNextDateButton:(id)sender;
- (IBAction)didTouchOnSelectDateButton:(id)sender;
- (IBAction)didTouchOnRefreshButton:(id)sender;

@property (nonatomic) NSArray *schedules;
@property (nonatomic) NSMutableArray *scheduleSlots;
@property (nonatomic) NSDate *currentDate;
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) UILabel *selectedDateLabel;

@property (nonatomic) BOOL needToReload;

@end

@implementation ECExaminationCalendarViewController

#pragma mark - ViewLife Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.needToReload = NO;
    
    self.currentDate = [NSDate date];
    
    [self setupUI];
    
    [self setupBinding];
    
    NotifReg(self, @selector(didUpdateSchedulesNotification:), ScheduleAddedOrUpdatedNotification);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.needToReload) {
        [self loadData];
    }
}

#pragma mark - Private Methods
- (void)setupUI{
 
    //Date picker
    self.datePicker = [[UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"VI"];
    [self.datePicker setLocale:locale];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.currentDateTextField.inputView = self.datePicker;
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    //Date picker bar
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    NSDictionary *fontAttribute = @{NSFontAttributeName: FontRobotoWithSize(13)};
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Xong", nil)
                                                                   style:UIBarButtonItemStyleDone target:self.currentDateTextField
                                                                  action:@selector(resignFirstResponder)];
    [doneButton setTitleTextAttributes:fontAttribute forState:UIControlStateNormal];

    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.selectedDateLabel = [[UILabel alloc] init];
    self.selectedDateLabel.textColor = UIColorFromHexaRGB(0x1565AF);
    self.selectedDateLabel.font = FontRobotoWithSize(13);
    self.selectedDateLabel.text = [[DateFormatter sharedInstance] stringFromDate:self.datePicker.date withFormat:@"EEEE, dd/MM/yyyy"];
    [self.selectedDateLabel sizeToFit];
    UIBarButtonItem *selectedDateBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectedDateLabel];
    
    [toolbar setItems:[NSArray arrayWithObjects:selectedDateBarItem, flexibleSpaceLeft, doneButton, nil]];
    
    self.currentDateTextField.inputAccessoryView = toolbar;
}

- (void)dateChanged:(id)sender
{
    self.selectedDateLabel.text = [[DateFormatter sharedInstance] stringFromDate:self.datePicker.date withFormat:@"EEEE, dd/MM/yyyy"];
    [self.selectedDateLabel sizeToFit];
}

- (void)setupBinding{
    @weakify(self);
    [RACObserve(self, currentDate) subscribeNext:^(NSDate *currentDate) {
        @strongify(self);
        self.currentDateLabel.text = [[DateFormatter sharedInstance] stringFromDate:currentDate withFormat:@"EEEE, dd/MM/yyyy"];
        [self loadData];
    }];
    
    
    [[self.currentDateTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        @strongify(self);
        self.currentDate = self.datePicker.date;
    }];
}

- (void)loadData{
    self.needToReload = NO;
    [self showLoadingInView:self.view];
    [[[ECSchedule signalGetSchedulesForDay:self.currentDate] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *schedules) {
        [self hideLoadingView];
        self.schedules = schedules;
        [self analyseSchedules];
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:[NSString stringWithFormat:@"Lấy lịch khám thất bại: %@", error.localizedDescription]];
    }];
}

- (void)analyseSchedules{
    self.scheduleSlots = [NSMutableArray array];
    NSDate *startTime = [[DateFormatter sharedInstance] timeFromString:@"07:00"];
    [self analyseSchedulesFromTime:startTime];
    [self.schedulesTableView reloadData];
}

- (void)analyseSchedulesFromTime:(NSDate *)dateTime{
    
    ECSchedule *roundlySchedule;
    
    for (ECSchedule *schedule in self.schedules) {
        if ([dateTime compare:schedule.startTime] != NSOrderedAscending && [dateTime compare:schedule.endTime] == NSOrderedAscending) {
            // startTime <= dateTime < endTime
            
            roundlySchedule = schedule;
            break;
        }
    }
    
    ECScheduleSlot *newSlot = [ECScheduleSlot new];
    if (roundlySchedule) {
        
        NSDate *nextPeriod;
        
        ECScheduleSlot *previousSlot = [self.scheduleSlots lastObject];
        BOOL endOfPreviousSchedule =  previousSlot.schedule != nil && [dateTime compare:previousSlot.schedule.endTime ] == NSOrderedSame;
            
        if ([dateTime minutesAfterDate:roundlySchedule.startTime] < [roundlySchedule.period integerValue] && !endOfPreviousSchedule){
            newSlot.startDate = roundlySchedule.startTime;
            nextPeriod = [roundlySchedule.startTime dateByAddingMinutes:[roundlySchedule.period integerValue]];
        }else{
            newSlot.startDate = dateTime;
            nextPeriod = [dateTime dateByAddingMinutes:[roundlySchedule.period integerValue]];
        }
        
        newSlot.schedule = roundlySchedule;
        [self.scheduleSlots addObject:newSlot];
        
        if ([nextPeriod compare:roundlySchedule.endTime] == NSOrderedDescending) {
            nextPeriod = roundlySchedule.endTime;
        }
        
        [self analyseSchedulesFromTime:nextPeriod];
    }else{
        newSlot.startDate = dateTime;
        [self.scheduleSlots addObject:newSlot];
        
        NSDate *nextPeriod = [dateTime dateByAddingMinutes:DEFAUTL_TIME_PERIOD];
        NSInteger detalMinute = nextPeriod.minute % DEFAUTL_TIME_PERIOD;
        if (detalMinute != 0) {
            nextPeriod = [nextPeriod dateByAddingMinutes:DEFAUTL_TIME_PERIOD - detalMinute];
        }

        if ([nextPeriod compare:[[DateFormatter sharedInstance] timeFromString:@"22:00"]] != NSOrderedDescending) {
            [self analyseSchedulesFromTime:nextPeriod];
        }
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.scheduleSlots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ECCalendarTableViewCell";
    ECCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.scheduleSlot = self.scheduleSlots[indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ECScheduleDetailViewController *detailViewController = [IBHelper loadViewController:@"ECScheduleDetailViewController" inStory:@"ExaminationCalendar"];
    detailViewController.currentDate = self.currentDate;
    detailViewController.scheduleSlot = self.scheduleSlots[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - Notifications
- (void)didUpdateSchedulesNotification:(NSNotification *)noti{
    self.needToReload = YES;
}

#pragma mark - Events

- (IBAction)didTouchOnSelectDateButton:(id)sender {
    [self.currentDateTextField becomeFirstResponder];
}

- (IBAction)didTouchOnBackDateButton:(id)sender {
    self.currentDate = [self.currentDate dateBySubtractingDays:1];
}

- (IBAction)didTouchOnNextDateButton:(id)sender {
    self.currentDate = [self.currentDate dateByAddingDays:1];
}
- (IBAction)didTouchOnRefreshButton:(id)sender {
    [self loadData];
}

@end
