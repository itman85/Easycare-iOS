//
//  DateTextField.m
//  EasyCare
//
//  Created by Chau luu on 12/21/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "DateTextField.h"
@interface DateTextField()


@end

@implementation DateTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    showRightArrow = YES;
    [super awakeFromNib];
    self.date = nil;

    self.datePicker = [[UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"VI"];
    [self.datePicker setLocale:locale];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.inputView = self.datePicker;
    
    @weakify(self);
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        @strongify(self);
        self.date = self.datePicker.date;
    }];
    
    [RACObserve(self, date) subscribeNext:^(NSDate *date) {
        @strongify(self);
        self.text = [[DateFormatter sharedInstance] stringFromDate:date withFormat:@"dd/MM/yyyy"];
        if (date) {
            [self.datePicker setDate:date animated:NO];
        }
    }];
    
    self.font = FontRobotoItalicWithSize(10);
//    self.backgroundColor = [UIColor clearColor];
}

@end
