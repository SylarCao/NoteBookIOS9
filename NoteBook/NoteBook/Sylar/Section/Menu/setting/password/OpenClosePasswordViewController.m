//
//  OpenClosePasswordViewController.m
//  NoteBook
//
//  Created by Sylar on 5/7/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////
#import "OpenClosePasswordViewController.h"
#import "MJPasswordView.h"
#import "PasswordHelper.h"
#import "CommonTools.h"
////////////////////////////////////////////////////////////////////
@interface OpenClosePasswordViewController ()
{
    NSString       *m_current_password;
    BlockCompletion m_completion;
}

@end
////////////////////////////////////////////////////////////////////
@implementation OpenClosePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_completion = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setOpenClose:(enOpenClosePassowrd)openClose
{
    _openClose = openClose;
    
    if (openClose == en_open_close_password_open)
    {
        m_state = en_change_password_state_new;
    }
    else if (openClose == en_open_close_password_close)
    {
        m_state = en_change_password_state_old_password;
    }
    [self RefreshState];
}

- (void) didCompletion:(BlockCompletion)completion
{
    m_completion = completion;
}


// delegate
- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    if (_openClose == en_open_close_password_open)
    {
        if (m_state == en_change_password_state_new)
        {
            m_current_password = password;
            m_state = en_change_password_state_confirm;
            [self RefreshState];
        }
        else if (m_state == en_change_password_state_confirm)
        {
            BOOL same = [m_current_password isEqualToString:password];
            if (same)
            {
                [PasswordHelper SetLoginPassword:password];
            }
            if (same)
            {
                [self ShowHudWithTitle:LocalizedString(@"ChangePassordSuccess") Complete:^(BOOL complete) {
                    [self BtnBack];
                    if (m_completion)
                    {
                        m_completion(YES);
                    }
                }];
            }
            else
            {
                [self ShowHudWithTitle:LocalizedString(@"ConfirmError") Complete:^(BOOL complete) {
                    m_state = en_change_password_state_new;
                    [self RefreshState];
                }];
            }
        }
    }
    else if (_openClose == en_open_close_password_close)
    {
        BOOL password_correct = [PasswordHelper CheckLoginPassword:password];
        if (password_correct)
        {
            [self BtnBack];
            if (m_completion)
            {
                m_completion(YES);
            }
        }
        else
        {
            m_state = en_change_password_incorrect;
            [self RefreshState];
        }
    }
}

@end
