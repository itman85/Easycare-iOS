//
//  ECReviewCell.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECComment.h"
@interface ECReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserComment;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentDesc;
@property (weak, nonatomic) IBOutlet UIView *commonReviewView;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommonStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommonStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommonStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommonStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommonStar5;

@property (weak, nonatomic) IBOutlet UIView *facilityView;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacilityStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacilityStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacilityStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacilityStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacilityStar5;

@property (weak, nonatomic) IBOutlet UIView *waittingTimeView;
@property (weak, nonatomic) IBOutlet UIImageView *imgWaitingTimeStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imgWaitingTimeStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imgWaitingTimeStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgWaitingTimeStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imgWaitingTimeStar5;

@property (nonatomic)ECComment *comment;


@end
