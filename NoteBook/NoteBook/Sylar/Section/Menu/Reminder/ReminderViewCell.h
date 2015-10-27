//
//  ReminderViewCell.h
//  NoteBook
//
//  Created by Sylar on 4/4/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ReminderViewCell : SWTableViewCell

@property (nonatomic, weak) id   parentView;

+ (NSString *) GetCellId;

- (void) SetWithData:(UILocalNotification *)notification;

- (NSArray *) SetRightButtons;

- (void) SwapDone;

- (UILocalNotification *) SwapDelete;

- (void) HideRedDot;


@end
