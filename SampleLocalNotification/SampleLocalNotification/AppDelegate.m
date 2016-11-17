//
//  AppDelegate.m
//  SampleLocalNotification
//
//  Created by 김성준 on 2016. 11. 7..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
    
    
    [app registerUserNotificationSettings:notificationSettings];
    
    NSDate *alertTime = [NSDate dateWithTimeIntervalSinceNow:10];
    
    UILocalNotification *notifyAlarm = [UILocalNotification new];
    
    notifyAlarm.fireDate = alertTime;
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    notifyAlarm.soundName = @"bell_tree.mp3";
    notifyAlarm.alertBody = @"Staff Meeting in 30 minutes";
    
    [app scheduleLocalNotification:notifyAlarm];
    
}


@end
