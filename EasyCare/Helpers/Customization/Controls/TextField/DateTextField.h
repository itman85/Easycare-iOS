//
//  DateTextField.h
//  EasyCare
//
//  Created by Chau luu on 12/21/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//


#import "BorderTextField.h"
@interface DateTextField : BorderTextField
@property (nonatomic) NSDate *date;
@property (nonatomic) UIDatePicker *datePicker;
@end
