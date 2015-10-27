//
//  NoteListNewCell.h
//  NoteBook
//
//  Created by Sylar on 3/27/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteListViewCell.h"

@interface NoteListNewCell : NoteListViewCell

+ (NSString *) GetCellId;

- (void) SetEditing:(BOOL)_editing;

@end
