//
//  ReminderDetailedViewController.m
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////
#import "ReminderDetailedViewController.h"
#import "CommonTools.h"
#import "ReminderHelper.h"
#import "SettingHelper.h"
///////////////////////////////////////////////////////////////////////////
@interface ReminderDetailedViewController ()
<UITextViewDelegate, UITextFieldDelegate>
{
    UIButton     *m_btn_right_navi;   // right navi
    UITextField  *m_title;            // title
    UITextView   *m_content;          // text view
    UILabel      *m_time;             // time show
    UIDatePicker *m_picker;           // pick
    UIButton     *m_btn_delete;       // delete
    CGRect        m_rect_small;
    CGRect        m_rect_big;
}
@end
///////////////////////////////////////////////////////////////////////////
const int c_reminder_detail_view_controller_label_height = 30;
///////////////////////////////////////////////////////////////////////////
@implementation ReminderDetailedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _state = en_reminder_state_create;
        [self SetInitialValue];
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

- (void) SetInitialValue
{
    [self SetNavi];
    [self SetContent];
}

- (void) SetNavi
{
    m_title = [[UITextField alloc] init];
    m_title.frame = CGRectMake(0, 0, 140, 40);
    m_title.text = LocalizedString(@"NewReminder");
    m_title.textAlignment = NSTextAlignmentCenter;
    m_title.delegate = self;
    self.navigationItem.titleView = m_title;
    
    // right button
    UIButton* btn_ok = [self GetNaviButtonWithTitle:LocalizedString(@"Done")];
    m_btn_right_navi = btn_ok;
    [btn_ok addTarget:self action:@selector(BtnRightNaviItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right_item = [[UIBarButtonItem alloc] initWithCustomView:btn_ok];
    [self.navigationItem setRightBarButtonItem:right_item];
}

- (void) SetContent
{
    // date pick
    m_picker = [[UIDatePicker alloc] init];
    float picker_height = m_picker.frame.size.height;
    m_picker.frame = CGRectMake(0, kSCREEN_HEIGHT-picker_height, kSCREEN_WIDTH, picker_height);
    [m_picker addTarget:self action:@selector(TimeChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:m_picker];
    
    // label
    float edge = 20;
    m_time = [[UILabel alloc] initWithFrame:CGRectMake(edge, kSCREEN_HEIGHT-picker_height-c_reminder_detail_view_controller_label_height, kSCREEN_WIDTH-edge, c_reminder_detail_view_controller_label_height)];
    m_time.text = [CommonTools GetStringFromDate:[NSDate date]];
    m_time.textColor = [UIColor redColor];
    [self.view addSubview:m_time];
    
    // text view
    int navi_height = [CommonTools GetNaviStatusBarHeight];
    int time_Y = m_time.frame.origin.y;
    int time_height = m_title.frame.size.height;
    edge = 5;
    m_rect_small = CGRectMake(edge, navi_height+edge, kSCREEN_WIDTH-2*edge, time_Y-navi_height-2*edge);
    m_rect_big = CGRectMake(edge, navi_height+edge, kSCREEN_WIDTH-2*edge, kSCREEN_HEIGHT-time_height-navi_height);
    m_content = [[UITextView alloc] initWithFrame:m_rect_small];
    m_content.delegate = self;
    int font_size = [[SettingHelper Share] GetFontSize];
    m_content.font = [UIFont systemFontOfSize:font_size];
    m_content.textColor = [UIColor darkTextColor];
    [m_content.layer setBorderColor:[UIColor blackColor].CGColor];
    [m_content.layer setBorderWidth:1.3];
    [m_content.layer setCornerRadius:5];
    [self.view addSubview:m_content];
    
    // gesture
    UISwipeGestureRecognizer* swap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(GestureKeyBoardDown:)];
    swap.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    [m_content addGestureRecognizer:swap];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureKeyBoardDown:)];
    [self.view addGestureRecognizer:tap];
}

- (void) GestureKeyBoardDown:(UIGestureRecognizer *)_gesture
{
    [m_content resignFirstResponder];
    [m_title resignFirstResponder];
}

- (void) TimeChange:(UIDatePicker *)picker
{
    m_time.text = [CommonTools GetStringFromDate:picker.date];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    textField.textAlignment = NSTextAlignmentLeft;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor clearColor];
    textField.textAlignment = NSTextAlignmentCenter;
}

- (void)textViewDidChange:(UITextView *)textView
{
    /***************************************************************************/
    // refer on line  否则最后一行会看不到
    /***************************************************************************/
    CGRect line = [textView caretRectForPosition:
                   
                   textView.selectedTextRange.start];
    
    CGFloat overflow = line.origin.y + line.size.height
    
    - ( textView.contentOffset.y + textView.bounds.size.height
       
       - textView.contentInset.bottom - textView.contentInset.top );
    
    if ( overflow > 0 ) {
        
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        
        // Scroll caret to visible area
        
        CGPoint offset = textView.contentOffset;
        
        offset.y += overflow + 0; // leave 7 pixels margin
        
        // Cannot animate with setContentOffset:animated: or caret will not appear
        
        [UIView animateWithDuration:.2 animations:^{
            
            [textView setContentOffset:offset];
            
        }];
    }
}

- (void) setState:(enReminderState)state
{
    _state = state;
    if (state == en_reminder_state_create)
    {
        m_title.enabled = YES;
        m_content.editable = YES;
        [self ShowTimePicker:YES];
        [m_btn_right_navi setTitle:LocalizedString(@"Create") forState:UIControlStateNormal];
    }
    else if (state == en_reminder_state_edit)
    {
        m_title.enabled = YES;
        m_content.editable = YES;
        [self ShowTimePicker:YES];
        [m_btn_right_navi setTitle:LocalizedString(@"Done") forState:UIControlStateNormal];
    }
    else if (state == en_reminder_state_view)
    {
        m_title.enabled = NO;
        m_content.editable = NO;
        [self ShowTimePicker:NO];
        [m_btn_right_navi setTitle:LocalizedString(@"Edit") forState:UIControlStateNormal];
    }
}

- (void) ShowTimePicker:(BOOL)show
{
    float delta_time = 0.5;
    CGRect label_frame = m_time.frame;
    CGRect picker_frame = m_picker.frame;
    if (show)
    {
        label_frame.origin.y = m_rect_small.origin.y+m_rect_small.size.height;
        picker_frame.origin.y = kSCREEN_HEIGHT-picker_frame.size.height;
        [UIView animateWithDuration:delta_time animations:^{
            m_content.frame = m_rect_small;
            m_time.frame = label_frame;
            m_picker.frame = picker_frame;
        }];
    }
    else
    {
        label_frame.origin.y = kSCREEN_HEIGHT-label_frame.size.height;
        picker_frame.origin.y = kSCREEN_HEIGHT+10;
        [UIView animateWithDuration:delta_time animations:^{
            m_content.frame = m_rect_big;
            m_time.frame = label_frame;
            m_picker.frame = picker_frame;
        }];
    }
}

- (void) setNotification:(UILocalNotification *)notification
{
    _notification = notification;
    NSDictionary *user_info = notification.userInfo;
    m_title.text = [user_info objectForKey:kReminderTitle];
    m_content.text = [user_info objectForKey:kReminderContent];
    m_time.text = [CommonTools GetStringFromDate:notification.fireDate];
    [m_picker setDate:notification.fireDate animated:YES];
}

- (void) BtnRightNaviItem
{
    if (_state == en_reminder_state_create)
    {
        // press create
        UILocalNotification *ll = [[UILocalNotification alloc] init];
        ll.fireDate = [CommonTools MaxDate1:m_picker.date Date2:[NSDate dateWithTimeIntervalSinceNow:10]];
        ll.applicationIconBadgeNumber = [[ReminderHelper Share] GetBadgeNumber]+1;
        ll.soundName = UILocalNotificationDefaultSoundName;
        ll.alertBody = m_title.text;
        ll.repeatInterval = NSCalendarUnitDay;
        ll.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                       m_title.text,   kReminderTitle,
                       m_content.text, kReminderContent,
                       @"0",           kReminderDone,
                       nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:ll];
//        [[ReminderHelper Share] RefreshBadgeNumber];
        [self BtnBack];
    }
    else if (_state == en_reminder_state_view)
    {
        // press edit
        self.state = en_reminder_state_edit;
    }
    else if (_state == en_reminder_state_edit)
    {
        // press done
        self.state = en_reminder_state_view;
        UILocalNotification *new_notification = _notification.copy;
        new_notification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  m_title.text,   kReminderTitle,
                                  m_content.text, kReminderContent,
                                  nil];
        new_notification.fireDate = [CommonTools MaxDate1:m_picker.date Date2:[NSDate dateWithTimeIntervalSinceNow:10]];
        new_notification.alertBody = m_title.text;
        new_notification.applicationIconBadgeNumber = [[ReminderHelper Share] GetBadgeNumber]+1;
        [[UIApplication sharedApplication] cancelLocalNotification:_notification];
        [[UIApplication sharedApplication] scheduleLocalNotification:new_notification];
        [[ReminderHelper Share] RefreshBadgeNumber];
    }
}

- (void) gestureSwapDown
{
    NSLog(@"down");
}

@end
