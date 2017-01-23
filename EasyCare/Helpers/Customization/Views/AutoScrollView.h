/*============================================================================
 PROJECT: EasyCare
 FILE:    AutoScrollView.h
 AUTHOR:  Vien Tran
 DATE:    12/14/14
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
 Interface:   AutoScrollView
 =============================================================================*/

@interface AutoScrollView : UIScrollView

@property(nonatomic, assign) float activeViewBottomMargin;
@property(nonatomic, assign) float extendKeyboardHeight;

- (void)enableCloseKeyboardWhenTouchOutSide:(BOOL)enable;

- (void)setFocusView:(UIView *)focusView;

@end