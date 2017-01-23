//
//  ECAcceptedAppointmentController.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/18/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BaseViewController.h"
#import "ECAppointmentCell.h"
#import "ECPageInfo.h"

#import "ECCareAppointmentDetailController.h"

@interface ECAcceptedAppointmentController : BaseViewController <UITableViewDataSource, UITableViewDelegate,ECAppointmentCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) ECPageInfo *pageInfo;
@property (strong, nonatomic) ECCareAppointmentDetailController *appointmentDetail;
@property (nonatomic) int currentPage;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
- (void)loadData;
- (void)reloadData;
@end
