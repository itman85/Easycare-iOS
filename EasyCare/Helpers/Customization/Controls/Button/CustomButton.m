/*============================================================================
 PROJECT: EasyCare
 FILE:    CustomButton.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "CustomButton.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/


@implementation CustomButton

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.font = [Utils appFontFromSourceFont:self.titleLabel.font];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
