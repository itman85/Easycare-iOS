/*============================================================================
 PROJECT: EasyCare
 FILE:    BlueButton.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "BlueButton.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation BlueButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.font = FontRobotoBoldWithSize(15);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:UIColorFromHexaRGB(0x03529C)];
    
    self.layer.cornerRadius = 1;
}

@end
