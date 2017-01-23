//
//  ECAppointmentCell.h
//  EasyCare
//
//  Created by Phan Nguyen on 1/1/15.
//  Copyright (c) 2015 Vien Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECAppointment.h"
@class ECAppointmentCell;
@protocol ECAppointmentCellDelegate<NSObject>
@optional
- (void)didFinishedRejectAppointment:(ECAppointmentCell *)cell;
- (void)didFinishedAcceptAppointment:(ECAppointmentCell *)cell;
- (void)didFinishedUpdateAppointment:(ECAppointmentCell *)cell;
@end

@interface ECAppointmentCell : UITableViewCell
{
    IBOutlet UILabel *lblPatientName;
    IBOutlet UILabel *lblBookDate;
    IBOutlet UILabel *lblPatient_notes;
    IBOutlet UIImageView *imgAvatar;
}
@property (nonatomic)ECAppointment *appointment;
@property (nonatomic)id<ECAppointmentCellDelegate>delegate;
@end
