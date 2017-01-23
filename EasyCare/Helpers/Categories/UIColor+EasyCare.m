/*============================================================================
 PROJECT: EasyCare
 FILE:    UIColor+EasyCare.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "UIColor+EasyCare.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation UIColor (EasyCare)


+ (UIColor*)textFieldTextColor{
    return UIColorFromHexaRGB(0x484848);
}

+ (UIColor*)textFieldBackgroundColor{
    return [UIColor whiteColor];
}

@end
