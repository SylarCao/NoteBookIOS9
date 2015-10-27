//
//  SaveVersionViewController.m
//  NoteBook
//
//  Created by Sylar on 3/31/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
//////////////////////////////////////////////////////////////////
#import "SaveVersionViewController.h"
#import "DataModel.h"
#import "CommonTools.h"
//////////////////////////////////////////////////////////////////
@interface SaveVersionViewController ()
{
    IBOutlet UITextField  *m_version_title;
    IBOutlet UILabel      *m_title;
    IBOutlet UILabel      *m_date;
    IBOutlet UILabel      *m_NSDate;
    IBOutlet UIButton     *m_btn_save;
}
@end
//////////////////////////////////////////////////////////////////
@implementation SaveVersionViewController

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
    [self SetNavi];
    
    [self SetNibView];

}

- (void) SetNavi
{
    [self SetNaviTitle:LocalizedString(@"SaveVersion")];
}

- (void) SetNibView
{
    UINib *nib = [UINib nibWithNibName:@"SaveVersion" bundle:nil];
    UIView *vv = [[nib instantiateWithOwner:self options:nil] lastObject];
    [self.view addSubview:vv];
    vv.backgroundColor = [UIColor clearColor];
    
    int navi_height = [CommonTools GetNaviStatusBarHeight];
    vv.frame =CGRectMake(0, navi_height, kSCREEN_WIDTH, kSCREEN_HEIGHT-navi_height);
    
    m_title.text = LocalizedString(@"Title");
    m_date.text = LocalizedString(@"Time");
    m_NSDate.text = [CommonTools GetStringFromDate:[NSDate date]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureTap)];
    [vv addGestureRecognizer:tap];
    
    // button
    [m_btn_save setTitle:LocalizedString(@"Save") forState:UIControlStateNormal];
    [m_btn_save.titleLabel setFont:[UIFont systemFontOfSize:30]];
    m_btn_save.titleLabel.shadowColor = [UIColor whiteColor];
    m_btn_save.titleLabel.shadowOffset = CGSizeMake(1, 1);
    [m_btn_save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_btn_save setBackgroundImage:[CommonTools GetResizeImageWithName:@"version_btn_bkg"] forState:UIControlStateNormal];
    [m_btn_save setBackgroundImage:[CommonTools GetResizeImageWithName:@"version_btn_bkg_HL"] forState:UIControlStateHighlighted];
    [m_btn_save addTarget:self action:@selector(BtnSave) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:m_btn_save];
}


- (void) BtnSave
{
    if (m_version_title.text.length < 2)
    {
        [m_version_title becomeFirstResponder];
    }
    else
    {
        BOOL save = [[DataModel Share] SaveCurrentWithTitle:m_version_title.text];
        if (save)
        {
            [self BtnBack];
        }
        else
        {
            [self ShowHudWithTitle:LocalizedString(@"SaveFail") Complete:nil];
        }
    }
}

- (void) GestureTap
{
    [m_version_title resignFirstResponder];
}


@end
