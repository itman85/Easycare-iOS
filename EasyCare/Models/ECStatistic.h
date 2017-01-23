//
//  ECStatistic.h
//  EasyCare
//
//  Created by Chau luu on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECStatistic : NSObject
@property (nonatomic)int totalViewed;
@property (nonatomic)int totalAppointment;
@property (nonatomic)int totalWaitingAppointment;
@property (nonatomic)int totalCommonRating;
@property (nonatomic)int totalFacilityRating;
@property (nonatomic)int totalWaitingTimeRating;
@property (nonatomic)int totalComment;
@property (nonatomic)float avgCommonRating;
@property (nonatomic)float avgFacilityRating;
@property (nonatomic)float avgWaitingTimeRating;
+ (ECStatistic*)statisticWithDictionary:(NSDictionary *)dict;

@end
