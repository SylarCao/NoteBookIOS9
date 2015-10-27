//
//  RevertVersionViewController.m
//  NoteBook
//
//  Created by Sylar on 4/1/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "RevertVersionViewController.h"
#import "CommonTools.h"
#import "RevertVersionTableViewCell.h"
#import "DataModel.h"
#import "RevertNoteListViewController.h"
#import "LocalVersion.h"
/////////////////////////////////////////////////////////////////////
@interface RevertVersionViewController ()
<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
{
    NSArray     *m_versions;
    UITableView *m_table;
}

@end
/////////////////////////////////////////////////////////////////////
@implementation RevertVersionViewController

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
}

- (void) SetNavi
{
    [self SetNaviTitle:LocalizedString(@"RevertVersion")];
    [self SetNaviBackItem];
}

- (void) SetTableView
{
    float navi_height = [CommonTools GetNaviStatusBarHeight];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, navi_height, kSCREEN_WIDTH, kSCREEN_HEIGHT-navi_height) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:table];
    m_table = table;
    
    [table registerNib:[UINib nibWithNibName:@"RevertVersionTableViewCell" bundle:nil] forCellReuseIdentifier:[RevertVersionTableViewCell GetCellId]];
}

// delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    m_versions = [[DataModel Share] GetPreviousVersions];
    return [m_versions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RevertVersionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RevertVersionTableViewCell GetCellId]];
    
    __block RevertVersionTableViewCell *the_cell = cell;
    [cell setAppearanceWithBlock:^{
        the_cell.delegate = self;
        the_cell.containingTableView = tableView;
        the_cell.leftUtilityButtons = nil;
        the_cell.rightUtilityButtons = [the_cell SetRightButtons];
        [the_cell setCellHeight:100];
    } force:NO];
    
    
    [cell SetWithData:[m_versions objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rt = 100;
    return rt;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RevertNoteListViewController *note = [RevertNoteListViewController CreateWithLocalVersion:[m_versions objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:note animated:YES];
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    if (index == 0)
    {
        NSIndexPath *indexPath = [m_table indexPathForCell:cell];
        LocalVersionItem *aItem = [m_versions objectAtIndex:indexPath.row];
        BOOL delete_success = [[LocalVersion Share] deleteLocalVersionWithTitle:aItem.title];
        if (delete_success)
        {
            [m_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.8];
        }
    }
}

- (void) reloadTableView
{
    [m_table reloadData];
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}


@end
