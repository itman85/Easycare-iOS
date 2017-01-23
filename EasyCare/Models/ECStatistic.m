//
//  ECStatistic.m
//  EasyCare
//
//  Created by Chau luu on 12/27/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECStatistic.h"

@implementation ECStatistic
+ (ECStatistic*)statisticWithDictionary:(NSDictionary *)dict
{
    ECStatistic *statistic = [ECStatistic new];
    statistic.totalViewed = [NotNillValue([dict objectForKey:@"totalViewed"]) intValue];
    statistic.totalAppointment = [NotNillValue([dict objectForKey:@"totalAppointment"]) intValue];
    statistic.totalWaitingAppointment = [NotNillValue([dict objectForKey:@"totalWaitingAppointment"]) intValue];
    statistic.totalCommonRating = [NotNillValue([dict objectForKey:@"totalCommonRating"]) intValue];
    statistic.totalFacilityRating = [NotNillValue([dict objectForKey:@"totalFacilityRating"]) intValue];
    statistic.totalWaitingTimeRating = [NotNillValue([dict objectForKey:@"totalWaitingTimeRating"]) intValue];
    statistic.totalComment = [NotNillValue([dict objectForKey:@"totalComment"]) intValue];
    statistic.avgCommonRating = [NotNillValue([dict objectForKey:@"avgCommonRating"]) floatValue];
    statistic.avgFacilityRating = [NotNillValue([dict objectForKey:@"avgFacilityRating"]) floatValue];
    statistic.avgWaitingTimeRating = [NotNillValue([dict objectForKey:@"avgWaitingTimeRating"]) floatValue];
    return statistic;
}
@end
