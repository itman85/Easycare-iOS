/*============================================================================
 PROJECT: EasyCare
 FILE:    LeftMenuTableViewCell.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "LeftMenuTableViewCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation LeftMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected) {
        [self setBackgroundColor:UIColorFromHexaRGB(0x0073de)];
        [self hideNewRecord];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setSampleData:(NSDictionary *)sampleData{
    if (_sampleData != sampleData) {
        _sampleData = sampleData;
        
        self.menuTitleLabel.text = self.sampleData[@"title"];
        self.menuIconImageView.image = [UIImage imageNamed:self.sampleData[@"icon"]];
    }
}

- (void)setUserCell:(BOOL)userCell{
    _userCell = userCell;
    if (self.userCell) {
        User *loggedUser = [User loggedUser];
        if (loggedUser) {
            [self.menuIconImageView setImageWithURL:[NSURL URLWithString:loggedUser.avatarThumbUrl]];
            [self.menuTitleLabel setText:loggedUser.fullName];
        }
        
        self.menuIconImageView.layer.cornerRadius = self.menuIconImageView.frame.size.height / 2;
    }else{
        self.menuIconImageView.layer.cornerRadius = 0;
    }
}
- (void)hideNewRecord
{
    self.viewNewRecord.hidden = YES;
}
- (void)updateNewRecordWithTitle:(NSString *)title
{
    self.viewNewRecord.hidden = NO;
    self.lblnewRecord.text = title;
}
@end
