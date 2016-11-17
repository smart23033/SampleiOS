//
//  AppDelegate.h
//  SampleUNNotification
//
//  Created by 김성준 on 2016. 11. 9..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)scheduleNotification:(NSDate *)date;

@end

