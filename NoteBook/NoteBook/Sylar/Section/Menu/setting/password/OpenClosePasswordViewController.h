//
//  OpenClosePasswordViewController.h
//  NoteBook
//
//  Created by Sylar on 5/7/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangPasswordViewController.h"
////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSInteger, enOpenClosePassowrd)
{
    en_open_close_password_open = 1,
    en_open_close_password_close = 2,
};
////////////////////////////////////////////////////////////////////////
typedef void (^BlockOpenClose)(BOOL completion);

////////////////////////////////////////////////////////////////////////
@interface OpenClosePasswordViewController : ChangPasswordViewController

@property (nonatomic, assign) enOpenClosePassowrd openClose;

- (void) didCompletion:(BlockCompletion)completion;

@end
