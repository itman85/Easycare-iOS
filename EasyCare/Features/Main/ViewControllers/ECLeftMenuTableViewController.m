/*============================================================================
 PROJECT: EasyCare
 FILE:    ECLeftMenuTableViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECLeftMenuTableViewController.h"
#import "LeftMenuTableViewCell.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
#import "Macros.h"

@interface ECLeftMenuTableViewController ()

@property (nonatomic) IBOutlet UITableView *tableMenu;
@property (nonatomic) NSArray *menuData;

@end

@implementation ECLeftMenuTableViewController

#pragma mark - ViewLife cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.menuData = @[
                      @{
                          @"title" : @"Test User",
                          @"icon" : @"avatar.jpg"
                          },
                      @{
                          @"title" : @"Quản lý hẹn khám",
                          @"icon" : @"icon_menu_care_appointment"
                          },
                      @{
                          @"title" : @"Tao lịch khám",
                          @"icon" : @"icon_menu_examination_calendar"
                          },
                      @{
                          @"title" : @"Danh sách bệnh nhân",
                          @"icon" : @"icon_menu_patient"
                          },
                      @{
                          @"title" : @"Nhận xét đánh giá",
                          @"icon" : @"icon_menu_patient"
                          },
                      @{
                          @"title" : @"Thoát",
                          @"icon" : @"icon_menu_patient"
                          },
                      ];
    
    NotifReg(self, @selector(reloadMenu), @"NewRecord");
}
- (void)reloadMenu
{
    [self.tableMenu reloadData];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.menuData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LeftMenuTableViewCell";
    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 1 && [[UIApplication sharedApplication] applicationIconBadgeNumber] > 0) {
        [cell updateNewRecordWithTitle:[NSString stringWithFormat:@"%ld",(long)[[UIApplication sharedApplication] applicationIconBadgeNumber]]];
    }
    else
    {
        [cell hideNewRecord];
    }
    
    cell.sampleData = self.menuData[indexPath.row];
    cell.userCell = indexPath.row == 0;
   
    return cell;
}

@end
