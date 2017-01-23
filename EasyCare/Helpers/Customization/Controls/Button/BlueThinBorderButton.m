//
//  BlueThinBorderButton.m
//  EasyCare
//
//  Created by Chau luu on 12/22/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BlueThinBorderButton.h"

@implementation BlueThinBorderButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setTitleColor:UIColorFromHexaRGB(0x1565b0) forState:UIControlStateNormal];
    [self.titleLabel setFont:FontRobotoWithSize(15)];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = UIColorFromHexaRGB(0x1565b0).CGColor;
    self.layer.cornerRadius = 2;
}
@end
