//
//  NoteListViewController.m
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "NoteListViewController.h"
#import "CommonTools.h"
#import "UICollectionView+Draggable.h"
#import "DraggableCollectionViewFlowLayout.h"
#import "NoteListViewCell.h"
#import "NoteListNewCell.h"
#import "PasswordViewController.h"
#import "DataModel.h"
#import "NoteListDetailedViewController.h"
#import "ItemModel.h"
#import "CommonActionSheet.h"
#import "MenuViewController.h"
/////////////////////////////////////////////////////////////////////
@interface NoteListViewController ()
<UICollectionViewDataSource_Draggable, UICollectionViewDelegate>
{
    UICollectionView *m_collection_view;
    BOOL              m_editing;
    UIButton         *m_btn_edit;
}
@end
/////////////////////////////////////////////////////////////////////
@implementation NoteListViewController

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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_collection_view reloadData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (m_editing)
    {
        [self BtnEdit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) SetInitialValue
{
    m_editing = NO;
    [self SetNaviBar];
    [self SetCollectionView];
}

- (void) SetNaviBar
{
    [self SetNaviTitle:LocalizedString(@"NoteListTitle")];
    
    [self SetNaviBackItem];
    
    // left  -> edit
    m_btn_edit = [self GetNaviButtonWithTitle:LocalizedString(@"Edit")];
    [m_btn_edit addTarget:self action:@selector(BtnEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item_left = [[UIBarButtonItem alloc] initWithCustomView:m_btn_edit];
    [self.navigationItem setLeftBarButtonItem:item_left];
    
    // right -> menu
    UIButton *menu = [self GetNaviButtonWithTitle:LocalizedString(@"Menu")];
    [menu addTarget:self action:@selector(BtnMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item_right = [[UIBarButtonItem alloc] initWithCustomView:menu];
    [self.navigationItem setRightBarButtonItem:item_right];
}

- (void) SetCollectionView
{
    DraggableCollectionViewFlowLayout* layout = [[DraggableCollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    float navi = [CommonTools GetNaviStatusBarHeight];
    CGRect collection_frame = CGRectMake(0, navi, kSCREEN_WIDTH, kSCREEN_HEIGHT-navi);
    m_collection_view = [[UICollectionView alloc] initWithFrame:collection_frame collectionViewLayout:layout];
    [m_collection_view setDraggable:NO];
    [m_collection_view setBackgroundColor:[UIColor clearColor]];
    [m_collection_view setDelegate:self];
    [m_collection_view setDataSource:self];
    [self.view addSubview:m_collection_view];
    
    [m_collection_view registerClass:[NoteListViewCell class] forCellWithReuseIdentifier:[NoteListViewCell GetCellId]];
    [m_collection_view registerClass:[NoteListNewCell class] forCellWithReuseIdentifier:[NoteListNewCell GetCellId]];
}

- (void) BtnMenu
{
    MenuViewController *mm = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:mm animated:YES];
}

- (void) BtnEdit
{
    if (m_editing)
    {
        // 结束编辑
        [m_btn_edit setTitle:LocalizedString(@"Edit") forState:UIControlStateNormal];
        m_editing = NO;
        m_collection_view.draggable = NO;
        [self CellEndEditing];
    }
    else
    {
        // 开始编辑
        [m_btn_edit setTitle:LocalizedString(@"Done") forState:UIControlStateNormal];
        m_editing = YES;
        m_collection_view.draggable = YES;
        [self CellBeginEditing];
    }
}

- (void) EndEdit
{
    if (m_editing)
    {
        [self BtnEdit];
    }
}

- (void) cbFromCellBeginEditing
{
    if (m_editing)
        return;
    m_editing = YES;
    m_collection_view.draggable = YES;
    [m_btn_edit setTitle:LocalizedString(@"Done") forState:UIControlStateNormal];
    [self CellBeginEditing];
}

- (void) CellBeginEditing
{
    NSArray *cells = [m_collection_view visibleCells];
    for (NoteListViewCell *each_cell in cells)
    {
        [each_cell SetEditing:YES];
    }
}

- (void) CellEndEditing
{
    NSArray *cells = [m_collection_view visibleCells];
    for (NoteListViewCell *each_cell in cells)
    {
        [each_cell SetEditing:NO];
    }
}

- (void) cbFromCellRemoveCell:(NoteListViewCell *)_cell
{
    CommonActionSheet* action = [CommonActionSheet Create];
    action.title = LocalizedString(@"SureDelete");
    action.cancelButtonTitle = LocalizedString(@"Cancel");
    action.destructiveButtonTitle = LocalizedString(@"Delete");
    action.showInView = self.view;
    
    [action ShowWithSelectedIndex:^(int index) {
        if (index == 0)
        {
            // delete
            [[DataModel Share] RemoveItem:_cell.data];
            NSIndexPath *path = [m_collection_view indexPathForCell:_cell];
            [m_collection_view deleteItemsAtIndexPaths:[NSArray arrayWithObject:path]];
            [self CellBeginEditing];
        }
    }];
}

// delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[DataModel Share] GetItemCount]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteListViewCell *cell = nil;
    if (indexPath.row == [[DataModel Share] GetItemCount])
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NoteListNewCell GetCellId] forIndexPath:indexPath];
        [cell SetWithTitle:LocalizedString(@"AddNewOne")];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NoteListViewCell GetCellId] forIndexPath:indexPath];
        cell.data = [[DataModel Share] GetItemAtIndex:indexPath.row];
        cell.delegate = self;
        [cell SetEditing:NO Animation:NO];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_editing)
        return;
    ItemModel *item = [[DataModel Share] GetItemAtIndex:indexPath.row];
    if (item == nil)
    {
        item = [[ItemModel alloc] init];
    }
    NoteListDetailedViewController* nn = [NoteListDetailedViewController CreateWithData:item];
    [self.navigationController pushViewController:nn animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[DataModel Share] MoveItemAtIndex:fromIndexPath.row To:toIndexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self CellBeginEditing];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [[DataModel Share] GetItemCount])
        return NO;
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    int cell_number = [[DataModel Share] GetItemCount];
    if (indexPath.row == cell_number)
        return NO;
    if (toIndexPath.row == cell_number)
        return NO;
    return YES;
}

@end
