/*============================================================================
 PROJECT: EasyCare
 FILE:    LeftMenuTableViewCell.h
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import <UIKit/UIKit.h>


/*============================================================================
 MACRO
 =============================================================================*/

/*============================================================================
 PROTOCOL
 =============================================================================*/

/*============================================================================
 Interface:   LeftMenuTableViewCell
 =============================================================================*/

@interface LeftMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *viewNewRecord;
@property (weak, nonatomic) IBOutlet UILabel *lblnewRecord;

@property (nonatomic) NSDictionary *sampleData;
@property (nonatomic) BOOL userCell;
- (void)hideNewRecord;
- (void)updateNewRecordWithTitle:(NSString *)title;
@end
