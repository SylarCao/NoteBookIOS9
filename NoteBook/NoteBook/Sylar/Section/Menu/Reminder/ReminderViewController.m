//
//  ReminderViewController.m
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import "ReminderViewController.h"
#import "CommonTools.h"
#import "ReminderDetailedViewController.h"
#import "ReminderHelper.h"
#import "ReminderViewCell.h"
////////////////////////////////////////////////////////////////////////////
@interface ReminderViewController ()
<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
{
    NSMutableArray   *m_reminders;
    UITableView      *m_table;
}
@end
////////////////////////////////////////////////////////////////////////////
@implementation ReminderViewController

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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_table reloadData];
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
}

- (void) SetNavi
{
    [self SetNaviTitle:LocalizedString(@"Reminder")];
    
    [self SetNaviBackItem];
    
    UIButton *create = [self GetNaviButtonWithTitle:LocalizedString(@"Create")];
    [create addTarget:self action:@selector(BtnCreate) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item_right = [[UIBarButtonItem alloc] initWithCustomView:create];
    [self.navigationItem setRightBarButtonItem:item_right];
}

- (void) BtnCreate
{
    ReminderDetailedViewController *rr = [[ReminderDetailedViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:rr animated:YES];
}

- (void) SetTableView
{
    int navi_height = [CommonTools GetNaviStatusBarHeight];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, navi_height, kSCREEN_WIDTH, kSCREEN_HEIGHT-navi_height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"ReminderViewCell" bundle:nil] forCellReuseIdentifier:[ReminderViewCell GetCellId]];
    m_table = table;
}

// delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *noti = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSArray *sort_arr = [noti sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *date1 = [(UILocalNotification *)obj1 fireDate];
        NSDate *date2 = [(UILocalNotification *)obj2 fireDate];
        return [date1 compare:date2];
    }];
    m_reminders = [[NSMutableArray alloc] initWithArray:sort_arr];
    int rt = [m_reminders count];
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReminderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ReminderViewCell GetCellId] forIndexPath:indexPath];
    
    __block ReminderViewCell *the_cell = cell;
    [cell setAppearanceWithBlock:^{
        the_cell.delegate = self;
        the_cell.containingTableView = tableView;
        the_cell.leftUtilityButtons = nil;
        the_cell.rightUtilityButtons = [the_cell SetRightButtons];
    } force:NO];
    
    UILocalNotification *noti = [m_reminders objectAtIndex:indexPath.row];
    [cell SetWithData:noti];
    cell.parentView = self;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ReminderDetailedViewController *rr = [[ReminderDetailedViewController alloc] initWithNibName:nil bundle:nil];
    rr.state = en_reminder_state_view;
    rr.notification = [m_reminders objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:rr animated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    if (index == 1)
    {
        // delete
        UILocalNotification *delete_notification = [(ReminderViewCell *)cell SwapDelete];
        if (delete_notification)
        {
            [[UIApplication sharedApplication] cancelLocalNotification:delete_notification];
            NSIndexPath *indexPath = [m_table indexPathForCell:cell];
            [m_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [self ShowHudWithTitle:LocalizedString(@"DeleteReminderFail") Complete:nil];
        }
    }
    else if (index == 0)
    {
        // done
        [(ReminderViewCell *)cell SwapDone];
        [cell hideUtilityButtonsAnimated:YES];
        [(ReminderViewCell *)cell HideRedDot];
    }
    [[ReminderHelper Share] RefreshBadgeNumber];
}


- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}


@end
