//
//  ECAppointmentCell.m
//  EasyCare
//
//  Created by Phan Nguyen on 1/1/15.
//  Copyright (c) 2015 Vien Tran. All rights reserved.
//

#import "ECAppointmentCell.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "Utils.h"
#import "BaseViewController.h"
@implementation ECAppointmentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setAppointment:(ECAppointment *)appointment
{
    if (_appointment != nil) {
        _appointment = nil;
        
    }
    _appointment = appointment;
    lblPatientName.text = _appointment.patient.fullName;
    lblBookDate.text = [[DateFormatter sharedInstance] stringFromDateTime:_appointment.time];
    lblPatient_notes.text = appointment.visit_reason;
    [imgAvatar setImageWithURL:[NSURL URLWithString:appointment.patient.avatarThumbUrl]];
    
}

- (IBAction)acceptAppointment:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishedAcceptAppointment:)])
    {
        [_delegate didFinishedAcceptAppointment:self];
    }

}
- (IBAction)rejectAppointment:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishedRejectAppointment:)])
    {
        [_delegate didFinishedRejectAppointment:self];
    }
    
}
- (IBAction)updateAppointment:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishedUpdateAppointment:)])
    {
        [_delegate didFinishedUpdateAppointment:self];
    }

}
@end
