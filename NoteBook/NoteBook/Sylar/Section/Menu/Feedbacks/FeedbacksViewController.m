//
//  FeedbacksViewController.m
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////
#import "FeedbacksViewController.h"
#import "CommonTools.h"
////////////////////////////////////////////////////////////
# define kFeedbackKeyboardHeight 260
////////////////////////////////////////////////////////////
@interface FeedbacksViewController ()
<UITextViewDelegate>
{
    UITextView *m_feedbacks;
}
@end
////////////////////////////////////////////////////////////
@implementation FeedbacksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self SetNaviBar];
    [self SetTextview];
}

- (void) SetNaviBar
{
    // title
    [self SetNaviTitle:LocalizedString(@"FeedBacks")];
    
    // right button
    UIButton* btn_feedback = [self GetNaviButtonWithTitle:LocalizedString(@"Send")];
    [btn_feedback addTarget:self action:@selector(BtnFeedback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right_item = [[UIBarButtonItem alloc] initWithCustomView:btn_feedback];
    [self.navigationItem setRightBarButtonItem:right_item];
}

- (void) BtnFeedback
{
    NSString *feedbacks = m_feedbacks.text;
    if (feedbacks.length < 2)
        return;
    [m_feedbacks resignFirstResponder];
//    [[AVOHelper Share] UploadFeedbacks:feedbacks Completion:^(BOOL complete) {
//        NSString *success = nil;
//        if (complete)
//        {
//            success = LocalizedString(@"FeedbacksSuccess");
//        }
//        else
//        {
//            success = LocalizedString(@"NetWorkFail");
//        }
//        [self ShowHudWithTitle:success Complete:^(BOOL complete) {
//            [self BtnBack];
//        }];
//    }];
}

- (void) SetTextview
{
    m_feedbacks = [[UITextView alloc] init];
    int navi_height = [CommonTools GetNaviStatusBarHeight];
    int edge = 5;
    m_feedbacks.frame = CGRectMake(5, navi_height+edge, kSCREEN_WIDTH-2*edge, kSCREEN_HEIGHT-navi_height-kFeedbackKeyboardHeight);
    m_feedbacks.font = [UIFont systemFontOfSize:14];
    m_feedbacks.textColor = [UIColor darkTextColor];
    m_feedbacks.delegate = self;
    [m_feedbacks.layer setBorderColor:[UIColor blackColor].CGColor];
    [m_feedbacks.layer setBorderWidth:1.3];
    [m_feedbacks.layer setCornerRadius:5];
    [self.view addSubview:m_feedbacks];
    [m_feedbacks becomeFirstResponder];
    
    // place holder text
    m_feedbacks.text = LocalizedString(@"FeedbackDefault");
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



@end
