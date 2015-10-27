//
//  MenuViewController.m
//  NoteBook
//
//  Created by Sylar on 3/28/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////
#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "ChangPasswordViewController.h"
#import "CommonTools.h"
#import "SaveVersionViewController.h"
#import "RevertVersionViewController.h"
#import "FeedbacksViewController.h"
#import "ReminderViewController.h"
#import "SettingViewController.h"
///////////////////////////////////////////////////////////////////////////
# define kMenuIndexPassword         100
# define kMenuIndexSaveVersion      1
# define kMenuIndexRevertVersion    2
# define kMenuIndexFeedbacks        4
# define kMenuIndexReminder         3
# define kMenuIndexSetting          0
///////////////////////////////////////////////////////////////////////////
@interface MenuViewController ()
<UITableViewDelegate, UITableViewDataSource>
{
    
}
@end
///////////////////////////////////////////////////////////////////////////
@implementation MenuViewController

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
    [self SetTableView];
    [self SetNaviBackItem];
}

- (void) SetNavi
{
    [self SetNaviTitle:LocalizedString(@"Menu")];
}

- (void) SetTableView
{
    float navi_height = [CommonTools GetNaviStatusBarHeight];
    CGRect table_frame = CGRectMake(0, navi_height, kSCREEN_WIDTH, kSCREEN_HEIGHT-navi_height);
    UITableView* table = [[UITableView alloc] initWithFrame:table_frame style:UITableViewStylePlain];
    table.backgroundColor = [UIColor lightGrayColor];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:table];
}

// delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MenuTableViewCell GetCellId]];
    if (cell == nil)
    {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MenuTableViewCell GetCellId]];
    }
    [cell SetWithTitle:[self GetTitleForIndexPath:indexPath]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self SelectIndexPath:indexPath];
}

// data
- (NSString *) GetTitleForIndexPath:(NSIndexPath *)indexPath
{
    NSString *rt = @"";
    int row = indexPath.row;
    if (row == kMenuIndexPassword)
    {
        rt = LocalizedString(@"ChangePassword");
    }
    else if (row == kMenuIndexSaveVersion)
    {
        rt = LocalizedString(@"SaveVersion");
    }
    else if (row == kMenuIndexRevertVersion)
    {
        rt = LocalizedString(@"RevertVersion");
    }
    else if (row == kMenuIndexFeedbacks)
    {
        rt = LocalizedString(@"FeedBacks");
    }
    else if (row == kMenuIndexReminder)
    {
        rt = LocalizedString(@"Reminder");
    }
    else if (row == kMenuIndexSetting)
    {
        rt = LocalizedString(@"Setting");
    }
    
    return rt;
}

- (void) SelectIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    if (row == kMenuIndexPassword)
    {
        ChangPasswordViewController *cc = [[ChangPasswordViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:cc animated:YES];
    }
    else if (row == kMenuIndexSaveVersion)
    {
        SaveVersionViewController *ss = [[SaveVersionViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ss animated:YES];
    }
    else if (row == kMenuIndexRevertVersion)
    {
        RevertVersionViewController *rr = [[RevertVersionViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:rr animated:YES];
    }
    else if (row == kMenuIndexFeedbacks)
    {
        FeedbacksViewController *ff = [[FeedbacksViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ff animated:YES];
    }
    else if (row == kMenuIndexReminder)
    {
        ReminderViewController *rr = [[ReminderViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:rr animated:YES];
    }
    else if (row == kMenuIndexSetting)
    {
        SettingViewController *ss = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ss animated:YES];
    }
}


@end
