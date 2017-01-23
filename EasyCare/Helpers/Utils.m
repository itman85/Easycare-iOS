/*============================================================================
 PROJECT: EasyCare
 FILE:    Utils.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "Utils.h"
#import "UIFont+Traits.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation Utils

+ (void)showMessage:(NSString *)message
{
    if (message.length> 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alertView show];
    }
}

+ (UIFont*)appFontFromSourceFont:(UIFont *)sourceFont{
    FontStyle currentFontStyle = [sourceFont fontStyle];
    if (currentFontStyle == FontStyleRegular) {
        return FontRobotoWithSize(sourceFont.pointSize);
    }else if (currentFontStyle == FontStyleBold){
        return FontRobotoBoldWithSize(sourceFont.pointSize);
    }else if (currentFontStyle == FontStyleItalic){
        return FontRobotoBoldItalicWithSize(sourceFont.pointSize);
    }else{
        return FontRobotoBoldItalicWithSize(sourceFont.pointSize);
    }
}

@end
