//
//  ChangPasswordViewController.h
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultViewController.h"
////////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSInteger, enChangePassordState)
{
    en_change_password_state_old_password = 1,
    en_change_password_state_new = 2,
    en_change_password_state_confirm = 3,
    en_change_password_incorrect = 4,
};
////////////////////////////////////////////////////////////////////////////////
@interface ChangPasswordViewController : DefaultViewController
{
    @public
    enChangePassordState  m_state;
}

- (void) RefreshState;

@end
