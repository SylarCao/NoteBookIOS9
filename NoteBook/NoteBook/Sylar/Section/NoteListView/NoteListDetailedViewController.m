//
//  NoteListDetailedViewController.m
//  NoteBook
//
//  Created by Sylar on 3/26/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
#import "NoteListDetailedViewController.h"
#import "ItemModel.h"
#import "CommonTools.h"
#import "DataModel.h"
#import "SettingHelper.h"
////////////////////////////////////////////////////////////////////////////////////
@interface NoteListDetailedViewController ()
<UITextViewDelegate, UITextFieldDelegate>
//{
//    ItemModel    *m_data;      // data
//    UITextField  *m_title;     // title
//    UITextView   *m_content;   // textview
//}
@end
////////////////////////////////////////////////////////////////////////////////////
@implementation NoteListDetailedViewController

+ (id) CreateWithData:(ItemModel *)_data
{
    id rt = [[NoteListDetailedViewController alloc] initWithData:_data];
    return rt;
}

- (id) initWithData:(ItemModel *)_data
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        m_data = _data;
        [self SetInitialValue];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) SetInitialValue
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self SetTextView];
    [self SetNaviBar];
}

- (void) SetNaviBar
{
    // title
    m_title = [[UITextField alloc] init];
    m_title.frame = CGRectMake(0, 0, 140, 40);
    m_title.text = m_data.title;
    m_title.textAlignment = NSTextAlignmentCenter;
    m_title.delegate = self;
    self.navigationItem.titleView = m_title;
    
    // right button
    UIButton* btn_ok = [self GetNaviButtonWithTitle:LocalizedString(@"Save")];
    [btn_ok addTarget:self action:@selector(BtnSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right_item = [[UIBarButtonItem alloc] initWithCustomView:btn_ok];
    [self.navigationItem setRightBarButtonItem:right_item];
}

- (void) SetTextView
{
    m_content = [[UITextView alloc] init];
    int navi_height = [CommonTools GetNaviStatusBarHeight];
    int edge = 5;
    m_content.frame = CGRectMake(5, navi_height+edge, kSCREEN_WIDTH-2*edge, kSCREEN_HEIGHT-navi_height-2*edge);
    int font_size = [[SettingHelper Share] GetFontSize];
    m_content.font = [UIFont systemFontOfSize:font_size];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 50, 0);
    m_content.contentInset = inset;
    m_content.textContainerInset = UIEdgeInsetsMake(5, 3, 5, 3);
    m_content.delegate = self;
    m_content.textColor = [UIColor darkTextColor];
    [m_content.layer setBorderWidth:2];
    [m_content.layer setCornerRadius:5];
    [m_content.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:m_content];
    m_content.text = m_data.content;
    
    // add gesture
    UISwipeGestureRecognizer* swap = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(GestureKeyBoardDown:)];
    swap.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    [m_content addGestureRecognizer:swap];
}

- (void) GestureKeyBoardDown:(UIGestureRecognizer *)_gesture
{
    [m_content resignFirstResponder];
    [m_title resignFirstResponder];
}

- (void) BtnSave
{
    // save title
    m_data.title = m_title.text;
    m_data.content = m_content.text;
    [[DataModel Share] SynchronizeWithEditingItem:m_data];
    [self BtnBack];
}


// delegate
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

- (void) KeyBoardWillShow:(NSNotification*)_notification
{
    CGRect rr = [[_notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    UIEdgeInsets inner = m_content.contentInset;
    inner.bottom = rr.size.height;
    m_content.contentInset = inner;
}

- (void) KeyBoardWillHide:(NSNotification*)_notification
{
    UIEdgeInsets inner = m_content.contentInset;
    inner.bottom = 0;
    m_content.contentInset = inner;
}



@end
