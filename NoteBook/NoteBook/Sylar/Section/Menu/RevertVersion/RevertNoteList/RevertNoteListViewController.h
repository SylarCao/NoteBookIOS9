//
//  RevertNoteListViewController.h
//  NoteBook
//
//  Created by Sylar on 4/3/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteListViewController.h"
@class LocalVersionItem;

@interface RevertNoteListViewController : NoteListViewController

+ (RevertNoteListViewController *)CreateWithLocalVersion:(LocalVersionItem *)item;

@end
