//
//  ECComment.h
//  EasyCare
//
//  Created by Chau luu on 12/28/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECComment : NSObject
@property (nonatomic)NSString *comment;
@property (nonatomic)NSString *commentID;
@property (nonatomic)NSString *avatar;
@property (nonatomic)NSString *avatar_thumb;
@property (nonatomic)NSString *full_name;
@property (nonatomic)NSString *userID_comment;
@property (nonatomic)NSString *comment_create_Date;
@property (nonatomic)int commonRating;
@property (nonatomic)int facilityRating;
@property (nonatomic)int waitingTimeRating;


+ (ECComment*)commentWithDictionary:(NSDictionary *)dict;
@end
