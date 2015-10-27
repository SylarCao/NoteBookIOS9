//
//  PopView.h
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockCompletion)(BOOL complete);

@interface PopView : UIView

- (id) initWithTitle:(NSString *)titleString;

- (id) initWithCustomView:(UIView *)customView;

- (void) ShowCompletion:(BlockCompletion)_block;


@end
