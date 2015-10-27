//
//  DefaultViewController.h
//  NoteBook
//
//  Created by Sylar on 3/11/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopView.h"

@interface DefaultViewController : UIViewController

// anvi
- (void) SetNaviTitle:(NSString *)_naviTitle;
- (UIButton *) GetNaviButtonWithTitle:(NSString *)_naviTitle;
- (void) SetNaviBackItem;

// back
- (void) BtnBack;

// password view
- (void) ShowPasswordView;

// common get button
- (UIButton *) GetButtonWithTitle:(NSString *)_pTitle;

// pop view
- (void) ShowHudWithTitle:(NSString *)pTitle Complete:(BlockCompletion)_block;
- (void) ShowHudWithTitle:(NSString *)pTitle DeltaTime:(float)deltaTime Complete:(BlockCompletion)_block;

@end
