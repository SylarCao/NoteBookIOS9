//
//  ReminderHelper.h
//  NoteBook
//
//  Created by Sylar on 4/4/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
////////////////////////////////////////////////////////////////
# define kReminderTitle    @"kReminderTitle"
# define kReminderContent  @"kReminderContent"
# define kReminderDone     @"kReminderDone"    // 1->Done  0->Undone
////////////////////////////////////////////////////////////////
@interface ReminderHelper : NSObject

+ (id) Share;

- (void) ClearBadgeNumber;

- (void) RefreshBadgeNumber;

- (int) GetBadgeNumber;

+ (BOOL) CheckNotificationBegin:(UILocalNotification *)notification;

+ (BOOL) CheckNotificationDone:(UILocalNotification *)notification;


@end
