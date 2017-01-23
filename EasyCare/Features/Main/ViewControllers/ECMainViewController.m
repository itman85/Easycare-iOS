/*============================================================================
 PROJECT: EasyCare
 FILE:    ECMainViewController.m
 AUTHOR:  Vien Tran
 DATE:    12/12/14
 =============================================================================*/

/*============================================================================
 IMPORT
 =============================================================================*/
#import "ECMainViewController.h"
#import "AMSlideMenuContentSegue.h"
#import "AMSlideMenuLeftMenuSegue.h"
#import "AMSlideMenuRightMenuSegue.h"
#import "IBHelper.h"
#import "User.h"
/*============================================================================
 PRIVATE MACRO
 =============================================================================*/
/*============================================================================
 PRIVATE INTERFACE
 =============================================================================*/

@interface ECMainViewController ()<AMSlideMenuMultipleStoryboarding>

@end

@implementation ECMainViewController


- (void)configureLeftMenuButton:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:@"nav-icon-menu"] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [[button rac_signalForControlEvents:UIControlEventAllEvents] subscribeNext:^(id x) {
        
    }];
}

//- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 0:
//            return @"homeView";
//            break;
//        case 1:
//            return @"examinationOrderManager";
//            break;
//        case 2:
//            return @"examinationCalendar";
//        default:
//            return @"homeView";
//            break;
//    }
//}

- (UINavigationController *)navigationControllerForIndexPathInLeftMenu:(NSIndexPath *)indexPath{
    UINavigationController *navigation;
    switch (indexPath.row) {
        case 0:
            navigation = [IBHelper loadViewController:@"HomeNavigationController" inStory:@"Main"];
            break;
        case 1:
            navigation = [IBHelper loadInitialViewControllerInStory:@"CareAppointment"];
            break;
        case 2:
            navigation = [IBHelper loadInitialViewControllerInStory:@"ExaminationCalendar"];
            break;
        case 3:
            navigation = [IBHelper loadInitialViewControllerInStory:@"Patients"];
            break;
        case 4:
            navigation = [IBHelper loadInitialViewControllerInStory:@"Reviews"];
            break;
        case 5: //Logout
        {
            [[[[User loggedUser] signalLogout] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                [appDelegate openLoginView];
            } error:^(NSError *error) {
                [Utils showMessage:error.localizedDescription];
            }];
            
        }
            break;
        default:
            navigation = [IBHelper loadViewController:@"HomeNavigationController" inStory:@"Main"];
            break;
    }

    return navigation;
}

@end
