//
//  ReminderHelper.m
//  NoteBook
//
//  Created by Sylar on 4/4/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////
#import "ReminderHelper.h"
//#import ""
///////////////////////////////////////////////////////////////
@interface ReminderHelper()
{
    UIApplication *m_application;
}
@end
///////////////////////////////////////////////////////////////
@implementation ReminderHelper

+ (id) Share
{
    static ReminderHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[ReminderHelper alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        m_application = [UIApplication sharedApplication];
    }
    return self;
}

- (void) ClearBadgeNumber
{
    m_application.applicationIconBadgeNumber = 0;
}

- (void) RefreshBadgeNumber
{
    int number = [self GetBadgeNumber];
    m_application.applicationIconBadgeNumber = number;
}

- (int) GetBadgeNumber
{
    int number = 0;
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *each in notifications)
    {
        BOOL start = [ReminderHelper CheckNotificationBegin:each];
        if (start)
        {
            BOOL done = [[each.userInfo objectForKey:kReminderDone] isEqualToString:@"1"];
            if (done == NO)
            {
                number ++;
            }
        }
    }
    return number;
}

+ (BOOL) CheckNotificationBegin:(UILocalNotification *)notification
{
    BOOL rt = YES;
    if ([notification.fireDate compare:[NSDate date]] == NSOrderedDescending)
    {
        rt = NO;
    }
    return rt;
}

+ (BOOL) CheckNotificationDone:(UILocalNotification *)notification
{
    BOOL rt = NO;
    if ([[notification.userInfo objectForKey:kReminderDone] isEqualToString:@"1"])
    {
        rt = YES;
    }
    return rt;
}

@end
