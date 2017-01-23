//
//  AppDelegate.h
//  EasyCare
//
//  Created by Vien Tran on 12/11/14.
//  Copyright (c) 2014 Vien Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *deviceToken;

- (void)openHomeView;
- (void)openLoginView;
- (void)registerPushNotificationWithServer;
@end

