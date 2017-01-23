//
//  BorderCustomView.m
//  TestTouchOnScrollView
//
//  Created by Chau luu on 12/18/14.
//  Copyright (c) 2014 Easycare. All rights reserved.
//

#import "BorderCustomView.h"
#import <QuartzCore/QuartzCore.h>
@implementation BorderCustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.layer setBorderWidth:1.0];
    [self.layer setCornerRadius:5.f];
    [self.layer setMasksToBounds:YES];
    [self.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowRadius:30.f];
}


@end
