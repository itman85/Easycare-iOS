/*============================================================================
 PROJECT: EasyCare
 FILE:    BlueBorderButton.m
 AUTHOR:  Vien Tran
 DATE:    12/15/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BlueBorderButton.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation BlueBorderButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setTitleColor:UIColorFromHexaRGB(0x1565b0) forState:UIControlStateNormal];
    [self.titleLabel setFont:FontRobotoBoldWithSize(8)];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColorFromHexaRGB(0x1565b0).CGColor;
    self.layer.cornerRadius = 2;
}

@end
