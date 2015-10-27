//
//  PopView.m
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////
#import "PopView.h"
/////////////////////////////////////////////////////////////////////////////////
@interface PopView()
{
    UIView          *m_pop_view;
    UILabel         *m_label;
    BlockCompletion  m_block;
    UITapGestureRecognizer *m_gesture_tap;
}
@end
/////////////////////////////////////////////////////////////////////////////////
@implementation PopView

- (id) initWithTitle:(NSString *)titleString
{
    self = [self init];
    if (self)
    {
        m_label = [[UILabel alloc] init];
        m_label.text = titleString;
        m_label.font = [UIFont systemFontOfSize:26];
        m_label.textAlignment = NSTextAlignmentLeft;
        m_label.numberOfLines = 0;
        m_label.frame = CGRectMake(0, 0, 280, 100);
        [m_label sizeToFit];
        CGRect frame = m_label.frame;
        int edge = 16;
        frame.origin.x = edge;
        frame.origin.y = edge;
        m_label.frame = frame;
        m_pop_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width+2*edge, frame.size.height+2*edge)];
        m_pop_view.backgroundColor = [UIColor lightGrayColor];
        [m_pop_view.layer setBorderColor:[UIColor whiteColor].CGColor];
        [m_pop_view.layer setBorderWidth:1.2];
        [m_pop_view.layer setCornerRadius:5];
        [m_pop_view addSubview:m_label];
        [self addSubview:m_pop_view];
    }
    return self;
}

- (id) initWithCustomView:(UIView *)customView
{
    self = [self init];
    if (self)
    {
        customView.center = self.center;
        [self addSubview:customView];
        m_pop_view = customView;
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self SetInitialValue];
    }
    return self;
}

- (void) SetInitialValue
{
    CGRect screen_bounds = [UIScreen mainScreen].bounds;
    [self setFrame:screen_bounds];
    
    // gray bkg
    UIView *bkg = [[UIView alloc] initWithFrame:screen_bounds];
    bkg.backgroundColor = [UIColor blackColor];
    bkg.alpha = 0.5;
    [self addSubview:bkg];
}

- (void) ShowCompletion:(BlockCompletion)_block
{
    m_block = _block;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self Show];
}

- (void) GestureTap
{
    [self removeGestureRecognizer:m_gesture_tap];
    [self Hide];
}

- (void) Show
{
    CGRect screen_bounds = [UIScreen mainScreen].bounds;
    CGRect frame = m_pop_view.frame;
    frame.origin.x = screen_bounds.size.width/2 - m_pop_view.frame.size.width/2;
    frame.origin.y = -frame.size.height;
    m_pop_view.frame = frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        m_pop_view.center = CGPointMake(screen_bounds.size.width/2, screen_bounds.size.height/2);
    } completion:^(BOOL finished) {
        if (finished)
        {
            m_gesture_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureTap)];
            [self addGestureRecognizer:m_gesture_tap];
        }
    }];
}

- (void) Hide
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = m_pop_view.frame;
        frame.origin.y = -frame.size.height;
        m_pop_view.frame = frame;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self removeFromSuperview];
        }
        if (m_block)
        {
            m_block(finished);
        }
    }];
}




@end
