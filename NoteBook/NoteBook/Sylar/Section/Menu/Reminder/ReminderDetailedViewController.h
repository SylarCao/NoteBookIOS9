//
//  ReminderDetailedViewController.h
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "DefaultViewController.h"
////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSInteger, enReminderState)
{
    en_reminder_state_create = 1,
    en_reminder_state_edit = 2,
    en_reminder_state_view = 3,
};
////////////////////////////////////////////////////////////////////////
@interface ReminderDetailedViewController : DefaultViewController

@property (nonatomic, assign) enReminderState      state;
@property (nonatomic, strong) UILocalNotification *notification;

@end
