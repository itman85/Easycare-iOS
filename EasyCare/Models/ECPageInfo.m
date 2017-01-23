//
//  ECPageInfo.m
//  EasyCare
//
//  Created by Chau luu on 12/30/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECPageInfo.h"

@implementation ECPageInfo
+(ECPageInfo *)pageWithDict:(NSDictionary *)dict
{
    ECPageInfo *page = [ECPageInfo new];
    page.total = [NotNillValue([dict objectForKey:@"total"]) intValue];
    page.currentPage = [NotNillValue([dict objectForKey:@"currentPage"]) intValue];
    page.lastPage = [NotNillValue([dict objectForKey:@"lastPage"]) intValue];
    page.itemsPerPage = [NotNillValue([dict objectForKey:@"itemsPerPage"]) intValue];
    return page;
}
@end
