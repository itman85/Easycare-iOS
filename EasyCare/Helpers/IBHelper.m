/*============================================================================
 PROJECT: EasyCare
 FILE:    IBHelper.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "IBHelper.h"

/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@implementation IBHelper

+ (NSString *)correctName:(NSString *)name {
    //    return [NSString stringWithFormat:@"%@%@", name, (IS_IPAD ? @"_iPad" : @"")];
    return name;
}

+ (id)loadViewNib:(NSString *)nibName {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:[self correctName:nibName] owner:nil options:nil];
    if([nibs count] > 0) {
        return [nibs objectAtIndex:0];
    }
    return nil;
}

+ (id)loadViewControllerNib:(NSString *)nibName {
    UIViewController *viewController = [[NSClassFromString(nibName) alloc] initWithNibName:[self correctName:nibName] bundle:nil];
    return viewController;
}

+ (id)loadStoryBoard:(NSString *)storyName {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[self correctName:storyName] bundle:nil];
    return storyBoard;
}

+ (id)loadViewController:(NSString *)name inStory:(NSString *)story {
    UIStoryboard *storyBoard = [self loadStoryBoard:story];
    return [storyBoard instantiateViewControllerWithIdentifier:name];
}

+ (id)loadInitialViewControllerInStory:(NSString *)story{
    UIStoryboard *storyBoard = [self loadStoryBoard:story];
    return [storyBoard instantiateInitialViewController];
}


@end
