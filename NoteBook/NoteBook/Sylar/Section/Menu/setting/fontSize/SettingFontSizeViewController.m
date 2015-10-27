//
//  SettingFontSizeViewController.m
//  NoteBook
//
//  Created by Sylar on 4/15/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////
#import "SettingFontSizeViewController.h"
#import "SettingHelper.h"
#import "CommonTools.h"
#import "SettingFontSizeDetailCell.h"
////////////////////////////////////////////////////////////////////////
@interface SettingFontSizeViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *m_table;
}
@end
////////////////////////////////////////////////////////////////////////
@implementation SettingFontSizeViewController

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSIndexPath *indexPath = [self GetIndexPathFromFontSize:[[SettingHelper Share] GetFontSize]];
    [self SetSelectedIndexPath:indexPath];
}

- (void) SetInitialValue
{
    [self SetNavi];
    [self SetTableView];
}

- (void) SetNavi
{
    [self SetNaviTitle:LocalizedString(@"SettingFontSize")];
    
    [self SetNaviBackItem];
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
    m_table = table;
    
    [table registerNib:[UINib nibWithNibName:@"SettingFontSizeDetailCell" bundle:nil] forCellReuseIdentifier:[SettingFontSizeDetailCell GetCellId]];
}

- (NSIndexPath *) GetIndexPathFromFontSize:(enSettingFontSize)fontSize
{
    NSIndexPath *rt = [NSIndexPath indexPathForRow:1 inSection:0];
    if (fontSize == en_setting_font_size_small)
    {
        rt = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else if (fontSize == en_setting_font_size_middle)
    {
        rt = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    else if (fontSize == en_setting_font_size_big)
    {
        rt = [NSIndexPath indexPathForRow:2 inSection:0];
    }
    return rt;
}

- (enSettingFontSize) GetFontSizeAtIndexPath:(NSIndexPath *)indexPath
{
    enSettingFontSize rt = en_setting_font_size_middle;
    int index = indexPath.row;
    if (index == 0)
    {
        rt = en_setting_font_size_small;
    }
    else if (index == 1)
    {
        rt = en_setting_font_size_middle;
    }
    else if (index == 2)
    {
        rt = en_setting_font_size_big;
    }
    return rt;
}

- (NSString *) GetTitleWithIndex:(int)index
{
    NSString *rt = @"";
    if (index == 0)
    {
        rt = LocalizedString(@"Small");
    }
    else if (index == 1)
    {
        rt = LocalizedString(@"Middle");
    }
    else if (index == 2)
    {
        rt = LocalizedString(@"Big");
    }
    return rt;
}

- (void) SetSelectedIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cells = [m_table visibleCells];
    SettingFontSizeDetailCell *selected_cell = (SettingFontSizeDetailCell *)[m_table cellForRowAtIndexPath:indexPath];
    for (SettingFontSizeDetailCell *each_cell in cells)
    {
        [each_cell SetTicked:(each_cell == selected_cell)];
    }
    enSettingFontSize font_size = [self GetFontSizeAtIndexPath:indexPath];
    [[SettingHelper Share] SetFontSize:font_size];
}

// delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingFontSizeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[SettingFontSizeDetailCell GetCellId] forIndexPath:indexPath];

    [cell SetWithTitle:[self GetTitleWithIndex:indexPath.row]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self SetSelectedIndexPath:indexPath];
    float delay = 0.2;
    [self performSelector:@selector(BtnBack) withObject:nil afterDelay:delay];
}

@end
