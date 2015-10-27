//
//  RevertNoteListViewController.m
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//
/////////////////////////////////////////////////////////////////////
#import "RevertNoteListViewController.h"
#import "CommonTools.h"
#import "LocalVersion.h"
#import "DataModel.h"
#import "NoteListViewCell.h"
#import "RevertNoteListDetailedViewController.h"
/////////////////////////////////////////////////////////////////////
@interface RevertNoteListViewController ()
{
    LocalVersionItem *m_local_version_item;
}
@end
/////////////////////////////////////////////////////////////////////
@implementation RevertNoteListViewController

+ (RevertNoteListViewController *)CreateWithLocalVersion:(LocalVersionItem *)item
{
    RevertNoteListViewController *rt = [[RevertNoteListViewController alloc] initWithLocalVersion:item];
    return rt;
}

- (id) initWithLocalVersion:(LocalVersionItem *)item
{
    m_local_version_item = item;
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        
    }
    return self;
}

- (void) SetNaviBar
{
    [self SetNaviTitle: m_local_version_item.title];
    
    [self SetNaviBackItem];
    
    // right navi button
    UIButton *revert = [self GetNaviButtonWithTitle:LocalizedString(@"NaviRevert")];
    [revert addTarget:self action:@selector(BtnRevert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item_right = [[UIBarButtonItem alloc] initWithCustomView:revert];
    [self.navigationItem setRightBarButtonItem:item_right];
    
}

- (void) BtnRevert
{
    CommonActionSheet* action = [CommonActionSheet Create];
    action.title = LocalizedString(@"SureRevert");
    action.cancelButtonTitle = LocalizedString(@"Cancel");
    action.destructiveButtonTitle = LocalizedString(@"NaviRevert");
    action.showInView = self.view;
    
    [action ShowWithSelectedIndex:^(int index) {
        if (index == 0)
        {
            // revert
            BOOL success = [[DataModel Share] RevertVersion:[m_local_version_item.items mutableCopy] PlistData:m_local_version_item.data];
            NSString *pop_title = nil;
            if (success)
            {
                pop_title = LocalizedString(@"RevertSuccess");
            }
            else
            {
                pop_title = LocalizedString(@"RevertFail");
            }
            [self ShowHudWithTitle:pop_title Complete:nil];
            
        }
    }];
}

// delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [m_local_version_item.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteListViewCell *cell = nil;

    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NoteListViewCell GetCellId] forIndexPath:indexPath];
    cell.data = [m_local_version_item.items objectAtIndex:indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RevertNoteListDetailedViewController *rr = [RevertNoteListDetailedViewController CreateWithData:[m_local_version_item.items objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:rr animated:YES];
}

- (void) cbFromCellBeginEditing
{
    
}


@end
