//
//  ECStatisticController.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BaseViewController.h"

@interface ECStatisticController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTotalViewed;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAppointment;
@property (weak, nonatomic) IBOutlet UILabel *lblWaitingAppointment;
@property (weak, nonatomic) IBOutlet UILabel *lblCommonRating;
@property (weak, nonatomic) IBOutlet UILabel *lblavgCommonRating;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalWaitingTimeRating;
@property (weak, nonatomic) IBOutlet UILabel *lblavgWaitingTimeRating;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalFacilityRating;
@property (weak, nonatomic) IBOutlet UILabel *lblavgFacilityRating;

@end
