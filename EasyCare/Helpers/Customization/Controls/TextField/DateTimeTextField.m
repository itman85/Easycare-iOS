/*============================================================================
 PROJECT: EasyCare
 FILE:    DateTimeTextField.m
 AUTHOR:  Vien Tran
 DATE:    12/20/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "DateTimeTextField.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface DateTimeTextField()

@end

@implementation DateTimeTextField

- (void)awakeFromNib{
    showRightArrow = YES;
    [super awakeFromNib];
    
    self.datePicker = [[UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [self.datePicker setLocale:locale];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker.minuteInterval = 5;
    self.inputView = self.datePicker;
    
//    self.datePicker.date = [[DateFormatter sharedInstance] timeFromString:@"11:11"];
    
//    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    @weakify(self);
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        @strongify(self);
        self.date = self.datePicker.date;
    }];
    
    [RACObserve(self, date) subscribeNext:^(NSDate *date) {
        @strongify(self);
        self.text = [[DateFormatter sharedInstance] timeStringFromDate:date];
        if (date) {
            [self.datePicker setDate:date animated:NO];
        }
    }];
}


//- (void)dateChanged:(id)sender
//{
//    self.date = self.datePicker.date;
//    self.text = [[DateFormatter sharedInstance] timeStringFromDate:self.date];
//}

@end
