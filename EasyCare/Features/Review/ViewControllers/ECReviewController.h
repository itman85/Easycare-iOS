//
//  ECReviewController.h
//  EasyCare
//
//  Created by Phan Nguyen on 12/18/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "BaseViewController.h"

@interface ECReviewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    int currentPage;
}
@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@end
