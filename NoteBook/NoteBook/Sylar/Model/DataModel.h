//
//  DataModel.h
//  NoteBook
//
//  Created by Sylar on 3/25/14.
//  Copyright (c) 2014 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemModel;

@interface DataModel : NSObject

+ (instancetype) Share;

// revert version
- (BOOL) RevertVersion:(NSMutableArray *)data PlistData:(NSMutableArray *)plistData;

- (NSInteger) GetItemCount;

- (ItemModel *) GetItemAtIndex:(NSInteger)_index;

- (void) MoveItemAtIndex:(NSInteger)_fromIndex To:(NSInteger)_toIndex;

- (void) AddItem:(ItemModel *)_item;

- (void) RemoveItem:(ItemModel *)_item;

- (void) SynchronizeWithEditingItem:(ItemModel *)_model;

- (void) Synchronize;

// save current version
- (BOOL) SaveCurrentWithTitle:(NSString *)_title;

// get previous version
- (NSArray *) GetPreviousVersions;

@end
