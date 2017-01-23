//
//  ECReviewCell.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECReviewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation ECReviewCell
- (void)setComment:(ECComment *)comment{
    if (_comment != comment) {
        _comment = comment;
        self.lblCommentDesc.text = _comment.comment;
        self.lblDateTime.text = _comment.comment_create_Date;
        self.lblUserComment.text = _comment.full_name;
        [self.imgAvatar setImageWithURL:[NSURL URLWithString:_comment.avatar_thumb]];
        [self loadCommontRating];
        [self loadFacilityRating];
        [self loadWaitingRating];
        
    }
}
-(void)loadCommontRating
{
    NSLog(@"Load gui for id = %@ with common rating %d", self.comment.commentID, self.comment.commonRating);
    [self.imgCommonStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgCommonStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgCommonStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgCommonStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgCommonStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    
    switch (self.comment.commonRating) {
        case 1:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 2:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 3:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 4:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 5:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgCommonStar5 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
            
        default:
        {
            [self.imgCommonStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgCommonStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgCommonStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgCommonStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgCommonStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            
            break;
        }
    }
}
- (void)loadFacilityRating
{
    NSLog(@"Load gui for id = %@ with facilityRating  %d", self.comment.commentID, self.comment.facilityRating);
    [self.imgFacilityStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgFacilityStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgFacilityStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgFacilityStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgFacilityStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    
    switch (self.comment.facilityRating) {
        case 1:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 2:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 3:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 4:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 5:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgFacilityStar5 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
            
        default:
        {
            [self.imgFacilityStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgFacilityStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgFacilityStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgFacilityStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgFacilityStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];

            break;
        }
    }

}
- (void)loadWaitingRating
{
    NSLog(@"Load gui for id = %@ with waitingTimeRating  %d", self.comment.commentID, self.comment.waitingTimeRating);
    [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgWaitingTimeStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgWaitingTimeStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    [self.imgWaitingTimeStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
    
    switch (self.comment.waitingTimeRating) {
        case 1:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 2:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 3:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 4:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
        case 5:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar3 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar4 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            [self.imgWaitingTimeStar5 setImage:[UIImage imageNamed:YELLOW_STAR_NAME]];
            break;
        }
            
        default:
        {
            [self.imgWaitingTimeStar1 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgWaitingTimeStar2 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgWaitingTimeStar3 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgWaitingTimeStar4 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            [self.imgWaitingTimeStar5 setImage:[UIImage imageNamed:GRAY_STAR_NAME]];
            
            break;
        }
    }

}
@end
