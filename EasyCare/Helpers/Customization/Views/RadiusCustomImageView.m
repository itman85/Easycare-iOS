//
//  RadiusCustomImageView.m
//  EasyCare
//
//  Created by Chau luu on 12/19/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "RadiusCustomImageView.h"

@implementation RadiusCustomImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code


}

- (void)awakeFromNib {
    NSLog(@"awake from nid");
    [super awakeFromNib];
    
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    [self.layer setBorderWidth:0.1];
    [self.layer setCornerRadius:self.frame.size.width/2];
    [self.layer setMasksToBounds:YES];
    [self setClipsToBounds:YES];
}
@end
