/*============================================================================
 PROJECT: EasyCare
 FILE:    WhiteButton.m
 AUTHOR:  Vien Tran
 DATE:    12/20/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "WhiteButton.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation WhiteButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.font = FontRobotoBoldWithSize(15);
    [self setTitleColor:UIColorFromHexaRGB(0x484848) forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.layer.cornerRadius = 1;
    self.layer.borderColor = UIColorFromHexaRGB(0xcecece).CGColor;
    self.layer.borderWidth = 1;
}

@end
