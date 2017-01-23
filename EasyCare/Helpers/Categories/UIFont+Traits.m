/*============================================================================
 PROJECT: EasyCare
 FILE:    UIFont+Traits.m
 AUTHOR:  Vien Tran
 DATE:    12/14/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "UIFont+Traits.h"
#import <CoreText/CoreText.h>
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation UIFont (Traits)

- (FontStyle)fontStyle{
    FontStyle style = FontStyleRegular;
    CTFontRef fontRef = (__bridge CTFontRef)self;
    CTFontSymbolicTraits symbolicTraits = CTFontGetSymbolicTraits(fontRef);
    
    if ((symbolicTraits & kCTFontBoldTrait) && (symbolicTraits & kCTFontItalicTrait)) {
        style = FontStyleBoldItalic;
    }else if ((symbolicTraits & kCTFontBoldTrait)){
        style = FontStyleBold;
    }else if ((symbolicTraits & kCTFontItalicTrait)){
        style = FontStyleItalic;
    }
    
    return style;
}

- (BOOL)isBold{
    return [self fontStyle] == FontStyleBold;
}

- (BOOL)isItalic{
    return [self fontStyle] == FontStyleItalic;
}

- (BOOL)isBoldItalic{
    return [self fontStyle] == FontStyleBoldItalic;
}

@end