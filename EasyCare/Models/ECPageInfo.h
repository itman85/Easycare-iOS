//
//  ECPageInfo.h
//  EasyCare
//
//  Created by Chau luu on 12/30/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECPageInfo : NSObject
@property(nonatomic)int total;
@property(nonatomic)int currentPage;
@property(nonatomic)int lastPage;
@property(nonatomic)int itemsPerPage;
+(ECPageInfo *)pageWithDict:(NSDictionary *)dict;
@end
