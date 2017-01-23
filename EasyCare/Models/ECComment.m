//
//  ECComment.m
//  EasyCare
//
//  Created by Chau luu on 12/28/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECComment.h"

@implementation ECComment
+ (ECComment*)commentWithDictionary:(NSDictionary *)dict
{
    NSLog(@"Comment : %@", dict);
    ECComment *comment = [ECComment new];
    comment.comment                 = NotNillValue([dict objectForKey:@"comment"]);
    comment.commonRating            = [NotNillValue([dict objectForKey:@"commonRating"]) intValue];
    comment.comment_create_Date     = NotNillValue([dict objectForKey:@"createdAt"]);
    comment.commentID               = NotNillValue([dict objectForKey:@"id"]);
    comment.waitingTimeRating       = [NotNillValue([dict objectForKey:@"waitingTimeRating"]) intValue];
    comment.facilityRating          = [NotNillValue([dict objectForKey:@"facilityRating"]) intValue];
    
    
    NSDictionary *commentBy         = NotNillValue([dict objectForKey:@"commentBy"]);
    comment.avatar                  = NotNillValue([commentBy objectForKey:@"avatar"]);
    comment.avatar_thumb            = NotNillValue([commentBy objectForKey:@"avatar_thumb"]);
    comment.full_name               = NotNillValue([commentBy objectForKey:@"full_name"]);
    comment.userID_comment          = NotNillValue([commentBy objectForKey:@"id"]);
    
    
    return comment;
}
@end
