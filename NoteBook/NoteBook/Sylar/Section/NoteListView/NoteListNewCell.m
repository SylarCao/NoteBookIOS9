//
//  NoteListNewCell.m
//  NoteBook
//
//  Created by Sylar on 3/27/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import "NoteListNewCell.h"

@implementation NoteListNewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self SetLabelFontSize:24];
    }
    return self;
}

+ (NSString *) GetCellId
{
    NSString *rt = @"c_note_list_new_cell_id";
    return rt;
}

- (void) SetEditing:(BOOL)_editing
{
    // did nothing
}
@end
