//
//  ECReviewController.m
//  EasyCare
//
//  Created by Phan Nguyen on 12/18/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "ECReviewController.h"
#import "User.h"
#import "ECReviewCell.h"
@interface ECReviewController ()
{
    NSMutableArray *commentsData;
}
@property (weak,nonatomic) IBOutlet UITableView *commentTable;
@end

@implementation ECReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    commentsData = [NSMutableArray array];
    currentPage = 1;
    [self loadData];
}
- (void)loadData
{
    [self showLoadingInView:self.view];
    
    [[[[User loggedUser] signalGetCommentsWithCurrentPage:currentPage] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id comments) {
        [commentsData addObjectsFromArray:comments];
        [self.commentTable reloadData];
        [self hideLoadingView];
         self.loadMoreButton.hidden = [comments count] == 0;
        
    } error:^(NSError *error) {
        [self hideLoadingView];
        [Utils showMessage:error.localizedDescription];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECReviewCell *cell = (ECReviewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
    [cell setComment:[commentsData objectAtIndex:indexPath.row]];
    
    return cell;
}
- (IBAction)loadMore:(id)sender
{
    currentPage++;
    [self loadData];

}
- (IBAction)refreshData:(id)sender {
    self.loadMoreButton.hidden = NO;
    currentPage = 1;
    [self loadData];
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
@end
