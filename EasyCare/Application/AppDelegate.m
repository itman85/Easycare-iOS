//
//  AppDelegate.m
//  EasyCare
//
//  Created by Vien Tran on 12/11/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import "AppDelegate.h"
#import "IBHelper.h"
#import "User.h"
#import "Macros.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //Set up default data
//    [MagicalRecord setupCoreDataStack];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self checkUserAlreadyLoggedIn];
    
    // register push notification
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];

    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
//    NSLog(@"badge number : %d", application.applicationIconBadgeNumber);
//    if (application.applicationIconBadgeNumber != 0 ) {
//        application.applicationIconBadgeNumber = 0;
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //Clean up Core Data
    [MagicalRecord cleanUp];
}


- (void)checkUserAlreadyLoggedIn{
    if ([User loggedUser]) {
        
        [self openHomeView];
        AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
        [appDel registerPushNotificationWithServer];

    }else{
        [self openLoginView];
    }
}

- (void)openHomeView{
    UINavigationController *rootNavigation = [IBHelper loadInitialViewControllerInStory:@"Main"];
    [self.window setRootViewController:rootNavigation];
    [self.window makeKeyAndVisible];
}

- (void)openLoginView{
    UINavigationController *rootNavigation = [IBHelper loadInitialViewControllerInStory:@"Login"];
    [self.window setRootViewController:rootNavigation];
    [self.window makeKeyAndVisible];
}

#pragma mark - Push notifcation response 
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);

    self.deviceToken = [NSString stringWithFormat:@"%@",deviceToken];
    self.deviceToken = [self.deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.deviceToken = [self.deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    self.deviceToken = [self.deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSUserDefaults *user =[ NSUserDefaults standardUserDefaults];
    [user setObject:self.deviceToken forKey:@"device_token"];
    [user synchronize];
    
    NSLog(@" token is: %@", self.deviceToken);
}
- (void)registerPushNotificationWithServer
{
    self.deviceToken =[[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    // register push notification
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    if ([self.deviceToken length] != 0)
    {
        [[[[User loggedUser] signalRegisterNotificationWithTokenDevice:appDel.deviceToken] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *result) {
            NSLog(@"REGISTER NOTIFICATION SUCCESSFULLY WITH TOKEN : %@",appDel.deviceToken);
        }error:^(NSError *error) {
            NSLog(@"REGISTER NOTIFICATION FAILED WITH TOKEN : %@",appDel.deviceToken);
            [Utils showMessage:error.localizedFailureReason];
        }];
    }

}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *message = NotNillValue([NotNillValue([userInfo objectForKey:@"aps"]) objectForKey:@"alert"]);
    int badge = [NotNillValue([NotNillValue([userInfo objectForKey:@"aps"]) objectForKey:@"badge"]) intValue];
    application.applicationIconBadgeNumber = badge;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewRecord" object:nil];
    
    if(application.applicationState == UIApplicationStateInactive) {
        
        NSLog(@"Inactive");
        
        //Show the view with the content of the push
        
    
        
    } else if (application.applicationState == UIApplicationStateBackground) {
        
        NSLog(@"Background");
        
        //Refresh the local model
        
        
        
    } else {
        
        NSLog(@"Active");
        
        //Show an in-app banner
        
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:message delegate:nil cancelButtonTitle:@"Đồng ý" otherButtonTitles: nil];
        [alert show];
        
    }

}

@end
