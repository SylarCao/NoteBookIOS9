//
//  DefaultViewController.m
//  NoteBook
//
//  Created by Sylar on 3/11/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "DefaultViewController.h"
#import "CommomColor.h"
#import "PasswordViewController.h"
#import "NoteListViewController.h"
#import "CommonTools.h"
#import "PopView.h"
#import "MBProgressHUD.h"
/////////////////////////////////////////////////////////////////////
@interface DefaultViewController ()

@end
/////////////////////////////////////////////////////////////////////
@implementation DefaultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self SetInitialValued];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self Once];
        });
    }
    return self;
}

//- (BOOL) prefersStatusBarHidden
//{
//    return YES;
//}

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

- (void) Once
{
    NSString *path = NSHomeDirectory();
    NSLog(@"home = %@", path);
}

- (void) SetInitialValued
{
    [self.view setBackgroundColor:[CommomColor GetBkgColor]];
    UILabel* lb = [[UILabel alloc] init];
    [self.view addSubview:lb];

}
- (void) SetNaviTitle:(NSString *)_naviTitle
{
    self.navigationItem.title = _naviTitle;
}

- (UIButton *) GetNaviButtonWithTitle:(NSString *)_naviTitle
{
    UIButton *rt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rt setFrame:CGRectMake(0, 0, 60, 36)];
    [rt setTitle:_naviTitle forState:UIControlStateNormal];
    [rt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [rt setBackgroundImage:[CommonTools GetResizeImageWithName:@"btn_bkg"] forState:UIControlStateNormal];
    [rt setBackgroundImage:[CommonTools GetResizeImageWithName:@"btn_bkg_highlighted"] forState:UIControlStateHighlighted];
    return rt;
}

- (void) SetNaviBackItem
{
    UIImage* back_normal = [UIImage imageNamed:@"navi_back"];
    UIImage* back_HL = [UIImage imageNamed:@"navi_back_highlighted"];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, back_normal.size.width/2, 0, back_normal.size.width/2-2);
    UIImage *back_normal_resize = [back_normal resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIImage *back_HL_resize = [back_HL resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:NULL];
    [back setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [back setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor clearColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    [back setBackButtonBackgroundImage:back_normal_resize forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [back setBackButtonBackgroundImage:back_HL_resize forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.navigationItem setBackBarButtonItem:back];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void) SetNaviBackItemWithTitle:(NSString *)_backTitle  // deprecate
{
    UIImage *back = [UIImage imageNamed:@"back_bkg"];
    UIImage *back_HL = [UIImage imageNamed:@"back_bkg_HL"];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 16, 0, 5);
    UIImage *back_resize = [back resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIImage *back_HL_resize = [back_HL resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    UIBarButtonItem* bb = [[UIBarButtonItem alloc] initWithTitle:_backTitle style:UIBarButtonItemStylePlain target:nil action:NULL];
    [bb setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [bb setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    [bb setBackButtonBackgroundImage:back_resize forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [bb setBackButtonBackgroundImage:back_HL_resize forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.navigationItem setBackBarButtonItem:bb];
}

- (void) BtnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) ShowPasswordView
{
    PasswordViewController* pp = [[PasswordViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:pp animated:YES completion:nil];
}

- (UIButton*) GetButtonWithTitle:(NSString*)_pTitle
{
    UIButton* rt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rt setTitle:_pTitle forState:UIControlStateNormal];
    [rt.layer setBorderColor:[UIColor blueColor].CGColor];
    [rt.layer setBorderWidth:2];
    [rt.layer setCornerRadius:10];
    [rt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rt setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    return rt;
}

- (void) ShowHudWithTitle:(NSString *)pTitle Complete:(BlockCompletion)_block
{
    [self ShowHudWithTitle:pTitle DeltaTime:0.8 Complete:_block];
}

- (void) ShowHudWithTitle:(NSString *)pTitle DeltaTime:(float)deltaTime Complete:(BlockCompletion)_block
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    UILabel *label = [[UILabel alloc] init];
    label.text = pTitle;
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, 0, 280, 100);
    [label sizeToFit];
    hud.customView = label;
    [hud show:YES];
    float time = deltaTime;
    [hud hide:YES afterDelay:time];
    [self performSelector:@selector(ShowHudHelperCompletion:) withObject:_block afterDelay:time];
}

- (void) ShowHudHelperCompletion:(BlockCompletion)_block
{
    if (_block)
    {
        _block(YES);
    }
}


@end
