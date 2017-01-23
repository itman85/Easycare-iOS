//
//  ECStatisticController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECStatisticController.h"
#import "User.h"
#import "ECStatistic.h"
#import "Utils.h"
#import "IBHelper.h"

@implementation ECStatisticController
- (void)viewDidLoad {
    [super viewDidLoad];

    [self showLoadingInView:self.view];
    
    [[[[User loggedUser] signalGetStatistic] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(ECStatistic *statistic) {
        [self hideLoadingView];
        // load UI from statistic response
        [self setGUIWithStatisticInfo:statistic];
        
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];

}

- (void)setGUIWithStatisticInfo:(ECStatistic *)statistic
{
    self.lblavgFacilityRating.text =[NSString stringWithFormat:@": %0.2f",statistic.avgFacilityRating];
    self.lblavgWaitingTimeRating.text = [NSString stringWithFormat:@": %0.2f",statistic.avgWaitingTimeRating];
    self.lblavgCommonRating.text =[NSString stringWithFormat:@": %0.2f",statistic.avgCommonRating];
    self.lblCommonRating.text = [NSString stringWithFormat:@": %d", statistic.totalCommonRating];
    self.lblTotalAppointment.text = [NSString stringWithFormat:@": %d",statistic.totalAppointment];
    self.lblTotalFacilityRating.text = [NSString stringWithFormat:@": %d", statistic.totalFacilityRating];
    self.lblTotalViewed.text = [NSString stringWithFormat:@": %d", statistic.totalViewed];
    self.lblTotalWaitingTimeRating.text = [NSString stringWithFormat:@": %d", statistic.totalWaitingTimeRating];
    self.lblWaitingAppointment.text = [NSString stringWithFormat:@": %d", statistic.totalWaitingAppointment];
    
}

- (IBAction)showWaitingAppointment:(id)sender
{
    [self.navigationController pushViewController:[IBHelper loadViewController:@"CareAppointmentViewController" inStory:@"CareAppointment"] animated:YES];
}
- (IBAction)refreshData:(id)sender {
    [self showLoadingInView:self.view];
    
    [[[[User loggedUser] signalGetStatistic] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(ECStatistic *statistic) {
        [self hideLoadingView];
        // load UI from statistic response
        [self setGUIWithStatisticInfo:statistic];
        
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];

    
}


@end
