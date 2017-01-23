/*============================================================================
 PROJECT: EasyCare
 FILE:    ECCalendarTableViewCell.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECCalendarTableViewCell.h"
#import "ECScheduleSlot.h"
#import "NSDate+Extensions.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/
@interface ECCalendarTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *fillView;

@end

@implementation ECCalendarTableViewCell

- (void)setScheduleSlot:(ECScheduleSlot *)scheduleSlot{
    if (_scheduleSlot != scheduleSlot) {
        _scheduleSlot = scheduleSlot;
        
        self.timeLabel.text = [[DateFormatter sharedInstance] timeStringFromDate:self.scheduleSlot.startDate];
        
        BOOL filled = self.scheduleSlot.schedule != nil;
        if (filled) {
            [self.fillView setBackgroundColor:UIColorFromHexaRGB(0x9ecbf5)];
        }else{
            [self.fillView setBackgroundColor:[UIColor whiteColor]];
        }

        BOOL blurred = [self.scheduleSlot.startDate minute] != 0;
        if (blurred) {
            [self.timeLabel setTextColor:UIColorFromHexaRGB(0xc8c8c8)];
        }else{
            [self.timeLabel setTextColor:UIColorFromHexaRGB(0x4c4c4c)];
        }
        
    }
}

@end
