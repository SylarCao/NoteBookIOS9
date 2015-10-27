//
//  ReminderViewCell.m
//  NoteBook
//
//  Created by Sylar on 4/4/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////
#import "ReminderViewCell.h"
#import "ReminderHelper.h"
#import "CommonTools.h"
#import "CommonActionSheet.h"
///////////////////////////////////////////////////////////////
@interface ReminderViewCell()
{
//    IBOutlet UIImageView *m_red_dot;
    IBOutlet UILabel     *m_title;
    UILocalNotification  *m_local_notification;
}

@property (nonatomic, weak) IBOutlet UIImageView *redDot;
@end
///////////////////////////////////////////////////////////////
@implementation ReminderViewCell

+ (NSString *) GetCellId
{
    NSString *rt = @"ReminderViewCell_id";
    return rt;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self SetInitialValue];
}

- (NSArray *) SetRightButtons
{
    NSMutableArray *rt = [[NSMutableArray alloc] init];
//    [rt sw_addUtilityButtonWithColor:[UIColor darkGrayColor] title:LocalizedString(@"Done")];
//    [rt sw_addUtilityButtonWithColor:[UIColor redColor] title:LocalizedString(@"Delete")];
    return rt;
}

- (void) SetInitialValue
{
    _redDot.hidden = YES;
    
    // swipe buttons
    MGSwipeButton *b1 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        if ([_cbDelegate respondsToSelector:@selector(ReminderViewCellDidTapDelete:)])
        {
            [_cbDelegate performSelector:@selector(ReminderViewCellDidTapDelete:) withObject:self];
        }
        return YES;
    }];
    MGSwipeButton *b2 = [MGSwipeButton buttonWithTitle:@"完成" backgroundColor:[UIColor grayColor] callback:^BOOL(MGSwipeTableCell *sender) {
        if (_redDot.isHidden == NO)
        {
            [self HideRedDot];
        }
        if ([_cbDelegate respondsToSelector:@selector(ReminderViewCellDidTapDone:)])
        {
            [_cbDelegate performSelector:@selector(ReminderViewCellDidTapDone:) withObject:self];
        }
        return YES;
    }];
    
    self.rightButtons = @[b1, b2];
}

- (void) SetWithData:(UILocalNotification *)notification
{
    m_local_notification = notification;
    
    // title
    m_title.text = [notification.userInfo objectForKey:kReminderTitle];
    
    //red dot
    BOOL start = [ReminderHelper CheckNotificationBegin:notification];
    BOOL done = [ReminderHelper CheckNotificationDone:notification];
    BOOL hide = (!start) || done;
    _redDot.hidden = hide;
}

- (void) HideRedDot
{
    _redDot.hidden = YES;
}

- (void) SwapDone
{
    if ([ReminderHelper CheckNotificationBegin:m_local_notification] && (![ReminderHelper CheckNotificationDone:m_local_notification]))
    {
        UILocalNotification *new_noti = m_local_notification.copy;
        NSMutableDictionary *user_info = [m_local_notification.userInfo mutableCopy];
        [user_info setObject:@"1" forKey:kReminderDone];
        new_noti.userInfo = user_info;
        new_noti.repeatInterval = NSCalendarUnitYear;
        [[UIApplication sharedApplication] cancelLocalNotification:m_local_notification];
        [[UIApplication sharedApplication] scheduleLocalNotification:new_noti];
        m_local_notification = new_noti;
    }
}

- (UILocalNotification *) SwapDelete
{
    UILocalNotification *rt = nil;
    if ([ReminderHelper CheckNotificationDone:m_local_notification] || [ReminderHelper CheckNotificationBegin:m_local_notification]==NO)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:m_local_notification];
        rt = m_local_notification;
    }
    return rt;
}

@end
