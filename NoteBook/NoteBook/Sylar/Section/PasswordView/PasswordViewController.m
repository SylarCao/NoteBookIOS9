//
//  PasswordViewController.m
//  NoteBook
//
//  Created by Sylar on 3/25/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////
#import "PasswordViewController.h"
#import "MJPasswordView.h"
#import "PasswordHelper.h"
#import "CommonTools.h"
#import "SettingHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>
////////////////////////////////////////////////////////////////////////////////////
const float c_securyView_title_height = 50;
const float c_securyView_title_font_size = 25;
static BOOL m_appear = NO;
////////////////////////////////////////////////////////////////////////////////////
@interface PasswordViewController ()
<MJPasswordDelegate>
{
    UILabel*   m_label_title;
    
}
@end
////////////////////////////////////////////////////////////////////////////////////
@implementation PasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self SetInitialValue];
        
            }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    m_appear = YES;
    
    if (TARGET_IPHONE_SIMULATOR == NO)
    {
        [self setWithTouchID];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    m_appear = NO;
}

+ (BOOL) checkAppear
{
    BOOL rt = m_appear;
    return rt;
}

- (void) SetInitialValue
{
    // add tap touchID gesture
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tap1];

    // title label
    m_label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, c_securyView_title_height)];
    [m_label_title setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    [m_label_title setText:LocalizedString(@"InputPassword")];
    [m_label_title setFont:[UIFont systemFontOfSize:c_securyView_title_font_size]];
    [m_label_title setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:m_label_title];
    
    // password view
    CGRect frame = CGRectMake((kSCREEN_WIDTH - kPasswordViewSideLength)/2, 0, kPasswordViewSideLength, kPasswordViewSideLength);
    MJPasswordView* password_view = [[MJPasswordView alloc] initWithFrame:frame];
    [password_view setDelegate:self];
    [password_view setP_image:[UIImage imageNamed:@"password"]];
    [password_view setP_image_highlighted:[UIImage imageNamed:@"password_highlighted"]];
    [self.view addSubview:password_view];
    
    // auto layout
    [CommonTools AutoLayoutVerticleView:self.view WithSubviews:[NSArray arrayWithObjects:m_label_title, password_view, nil] TopEdge:0 BottomEdge:20 NeedCenter:YES];
    
    // add gesture
    UITapGestureRecognizer *long_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTap10)];
    long_tap.numberOfTapsRequired = 10;
    m_label_title.userInteractionEnabled = YES;
    [m_label_title addGestureRecognizer:long_tap];
}

- (void) gestureTap10
{
    [[SettingHelper Share] SetPasswordOnOff:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapView:(UITapGestureRecognizer *)aTap
{
    CGPoint tap_location = [aTap locationInView:m_label_title];
    BOOL in_label = CGRectContainsPoint(m_label_title.bounds, tap_location);
    if (in_label == NO)
    {
        [self setWithTouchID];
    }
}

- (void) setWithTouchID
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"指纹解锁";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[SettingHelper Share] SynchronizePasswordTime];
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                    });
                                }
                            }];
    }
}

// delegate
- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    BOOL password_right = [PasswordHelper CheckLoginPassword:password];
    if (password_right)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
