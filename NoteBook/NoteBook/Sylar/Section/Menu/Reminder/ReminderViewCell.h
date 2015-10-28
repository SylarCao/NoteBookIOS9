//
//  ReminderViewCell.h
//  NoteBook
//
//  Created by Sylar on 4/4/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
@class ReminderViewCell;
///////////////////////////////////////////////////////////////
@protocol ReminderViewCellDelegate <NSObject>

@optional
- (void) ReminderViewCellDidTapDelete:(ReminderViewCell *)cell;
- (void) ReminderViewCellDidTapDone:(ReminderViewCell *)cell;

@end
///////////////////////////////////////////////////////////////
@interface ReminderViewCell : MGSwipeTableCell

@property (nonatomic, weak) id   parentView;


@property (nonatomic, weak) id<ReminderViewCellDelegate> cbDelegate;


+ (NSString *) GetCellId;

- (void) SetWithData:(UILocalNotification *)notification;

- (void) SwapDone;

- (UILocalNotification *) SwapDelete;

- (void) HideRedDot;


@end
