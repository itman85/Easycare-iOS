//
//  CircleCustomView.m
//  EasyCare
//
//  Created by Chau luu on 1/15/15.
//  Copyright (c) 2015 Vien Tran. All rights reserved.
//

#import "CircleCustomLabel.h"

@implementation CircleCustomLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    [self.layer setBorderWidth:0.1];
    [self.layer setCornerRadius:self.frame.size.width/2];
    [self.layer setMasksToBounds:YES];
    [self setClipsToBounds:YES];
}
@end
