//
//  AppDelegate.m
//  SampleUNNotification
//
//  Created by 김성준 on 2016. 11. 9..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                                  //                                  [self showAlert];
                              }
                          }];
    
    return YES;
}

- (void)scheduleNotification:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
   
    NSInteger minuteComponent = [calendar component:NSCalendarUnitMinute fromDate:date];
    NSInteger hourComponent = [calendar component:NSCalendarUnitHour fromDate:date];
    NSInteger dateComponent = [calendar component:NSCalendarUnitDay fromDate:date];
    NSInteger monthComponent = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger yearComponent = [calendar component:NSCalendarUnitYear fromDate:date];
    
    
    NSDateComponents *newComponents = [NSDateComponents new];
    newComponents.day = dateComponent;
    newComponents.month = monthComponent;
    newComponents.year = yearComponent;
    newComponents.minute = minuteComponent;
    newComponents.hour = hourComponent;
    newComponents.calendar = calendar;
    newComponents.timeZone = [NSTimeZone defaultTimeZone];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:false];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Reminder";
    content.body = @"just reminder to read your tutorial";
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    content.categoryIdentifier = @"myCategory";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"textNotification" content:content trigger:trigger];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError *error){
        if(error){
            NSLog(@"error : %@",[error localizedDescription]);
        }
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    if([response.actionIdentifier isEqualToString:@"remindLater"]){
        NSDate *newDate = [NSDate dateWithTimeInterval:600 sinceDate:[NSDate new]];
        [self scheduleNotification:newDate];
    }
}

@end
