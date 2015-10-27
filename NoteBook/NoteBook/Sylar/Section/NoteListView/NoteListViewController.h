//
//  NoteListViewController.h
//  NoteBook
//
//  Created by Sylar on 3/12/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultViewController.h"
@class NoteListViewCell;

@interface NoteListViewController : DefaultViewController

- (void) cbFromCellRemoveCell:(NoteListViewCell *)_cell;

- (void) cbFromCellBeginEditing;

- (void) EndEdit;

@end
